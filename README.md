# FHHGitInfo

Goal：Get GitInfo in iOS App   
We want to get GitCommitSHA,GitCommitBranch,GitCommitUser,GitCommitDate.

Way：Config Xcode's script，then we set the GitInfo in the info.plist，and get GitInfo from info.plist when needed.


### Step1
Xcode-Build Phases-New Run Script Phase
![step1.png](http://upload-images.jianshu.io/upload_images/2351207-7503a527f7acc53f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Suggestion:rename 'Run Script' to "Git Script" 
![step12.png](http://upload-images.jianshu.io/upload_images/2351207-d79b8fd5af1d7d29.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Step2
add entrys to you target'info.plist as the below picture.


![step22.png](http://upload-images.jianshu.io/upload_images/2351207-c1a44476cfe3000d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### Step3
copy the below Script to Git Script：
``` 
#最后一次提交的SHA
git_sha=$(git rev-parse HEAD)

#当前的分支
git_branch=$(git symbolic-ref --short -q HEAD)

#最后一次提交的作者
git_last_commit_user=$(git log -1 --pretty=format:'%an')

#最后一次提交的时间
git_last_commit_date=$(git log -1 --format='%cd')

#获取App安装包下的info.plist文件路径
info_plist="${BUILT_PRODUCTS_DIR}/${EXECUTABLE_FOLDER_PATH}/Info.plist"

#利用PlistBuddy改变info.plist的值
/usr/libexec/PlistBuddy -c "Set :'GitCommitSHA'       '${git_sha}'"                "${info_plist}"
/usr/libexec/PlistBuddy -c "Set :'GitCommitBranch'    '${git_branch}'"                 "${info_plist}"
/usr/libexec/PlistBuddy -c "Set :'GitCommitUser'      ${git_last_commit_user}"       "${info_plist}"
/usr/libexec/PlistBuddy -c "Set :'GitCommitDate'      '${git_last_commit_date}'"       "${info_plist}""
```


![step2.png](http://upload-images.jianshu.io/upload_images/2351207-334b9aab9761a9f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Step4
get GitInfo
```
- (NSDictionary *)p_gitInfoDict {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *gitSHA = [infoDict objectForKey:@"GitCommitSHA"];
    NSString *gitBranch = [infoDict objectForKey:@"GitCommitBranch"];
    NSString *gitCommitUser = [infoDict objectForKey:@"GitCommitUser"];
    NSString *gitCommitDate = [infoDict objectForKey:@"GitCommitDate"];
    gitSHA = [@"GitSHA:" stringByAppendingString:(gitSHA == nil ? @"" : gitSHA)];
    gitBranch = [@"GitBranch:" stringByAppendingString:(gitBranch == nil ? @"" : gitBranch)];
    gitCommitUser = [@"GitCommitUser:" stringByAppendingString:(gitCommitUser == nil ? @"" : gitCommitUser)];
    gitCommitDate = [@"GitCommitDate:" stringByAppendingString:(gitCommitDate == nil ? @"" : gitCommitDate)];
    
    NSDictionary *gitDict = @{@"gitSHA" : gitSHA,
                              @"gitBranch" : gitBranch,
                              @"gitCommitUser" : gitCommitUser,
                              @"gitCommitDate" : gitCommitDate};
    return gitDict;
}
```

### Tip:
1、The script is all the same in Mutiple Target project，you don't have to rewrite the below script code
```
info_plist="${BUILT_PRODUCTS_DIR}/${EXECUTABLE_FOLDER_PATH}/Info.plist"
```
For why,you could view the page:[Xcode Environment variable](http://blog.csdn.net/fengsh998/article/details/8869497)  
2、If you run in Xcode simulator,when you deleted the script then uninstall the app and run, you would still get the git info.you have to reset the simulator then the gitInfo cleared。  
3、If you run the FHHGitInfo you download directly,the gitInfo doesn't exist.Because the project you donwload don't exist gitCommit,you could make some change you commit to you local then run，and the GitInfo shown.

Reference:  
[Reference Article](http://www.cocoachina.com/bbs/read.php?tid-1722191.html)  
[GitCommitInfo](https://git-scm.com/book/zh/v1/Git-基础-查看提交历史)  
[PlistBuddy](http://www.jianshu.com/p/2167f755c47e)   
[Xcode Environment variable](http://blog.csdn.net/fengsh998/article/details/8869497)