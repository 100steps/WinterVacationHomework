//
//  MeViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "XMPPStreamManager.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"退出"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    //设置触发器
    [button addTarget:self action:@selector(exitDidClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)exitDidClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"废话！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //清空好友信息缓存
        [[XMPPStreamManager sharedManager].indexDic removeAllObjects];
        //当用户确定要退出时，先删除“SomeStatus文件”
         NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        //调用backToHome方法
        [((AppDelegate *)[UIApplication sharedApplication].delegate) backToHome];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错啦！" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
