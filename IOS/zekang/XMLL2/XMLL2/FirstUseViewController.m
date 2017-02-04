//
//  FirstUseViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "FirstUseViewController.h"
#import "FirstUseView.h"
#import "RegisterViewController.h"
@interface FirstUseViewController ()
@property (nonatomic,strong)FirstUseView *firstUseView;
@end

@implementation FirstUseViewController

- (void)loadView{
   self.firstUseView = [[FirstUseView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.firstUseView viewAddTo:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加点击事件
    [_firstUseView.registerBtn addTarget:self action:@selector(BtnDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    [_firstUseView.loginBtn addTarget:self action:@selector(BtnDidTouch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    //回到开始页面的时候要把导航条隐藏
     self.navigationController.navigationBar.hidden = YES;
}

- (void)BtnDidTouch:(UIButton *)sender{
    //根据button的标题来部署导航条的标题，然后根据导航条的标题来部署是注册还是登录页面，有点像是网页中的get请求吧
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    self.navigationController.navigationBar.hidden = NO;
        registerVC.navigationItem.title = sender.currentTitle;
        [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
