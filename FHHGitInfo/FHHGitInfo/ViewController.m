//
//  ViewController.m
//  FHHGitInfo
//
//  Created by hefanghui on 2017/9/6.
//  Copyright © 2017年 002. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
@property (weak, nonatomic) IBOutlet UILabel *gitSHALabel;
@property (weak, nonatomic) IBOutlet UILabel *gitCommitUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *gitBranchLabel;
@property (weak, nonatomic) IBOutlet UILabel *gitCommitDateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self p_configSubViews];
}
    
- (void)p_configSubViews {
    _gitSHALabel.text = [self p_gitInfoDict][@"gitSHA"];
    _gitCommitUserLabel.text = [self p_gitInfoDict][@"gitCommitUser"];
    _gitBranchLabel.text = [self p_gitInfoDict][@"gitBranch"];
    _gitCommitDateLabel.text = [self p_gitInfoDict][@"gitCommitDate"];
    
    [_gitSHALabel sizeToFit];
    [_gitCommitUserLabel sizeToFit];
    [_gitBranchLabel sizeToFit];
    [_gitCommitDateLabel sizeToFit];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
