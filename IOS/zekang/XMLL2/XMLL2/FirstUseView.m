//
//  FirstUseView.m
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "FirstUseView.h"

@implementation FirstUseView
- (UIButton *)registerBtn{
    if (_registerBtn == nil){
        _registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _registerBtn.frame = CGRectMake(10, 568 - 30 - 40, 145, 40);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.showsTouchWhenHighlighted = YES;
        _registerBtn.backgroundColor = [UIColor greenColor];
    }
    return _registerBtn;
}
- (UIButton *)loginBtn{
    if (_loginBtn == nil){
        _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _loginBtn.frame = CGRectMake(10 + 145 + 10, 568 - 30 - 40 , 145, 40);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.showsTouchWhenHighlighted = YES;
        _loginBtn.backgroundColor = [UIColor blueColor];
    }
    return _loginBtn;
}
//客制view
- (void)viewAddTo:(UIViewController *)viewController{
    //背景色和背景图
    self.backgroundColor = [UIColor whiteColor];
    UIImage *BGImage = [UIImage imageNamed:@"Background"];
    UIImageView *BGView = [[UIImageView alloc]initWithImage:BGImage];
    BGView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:BGView];
    
    //添加注册的button
    [self addSubview:self.registerBtn];
    
    //添加登录的button
    [self addSubview:self.loginBtn];
    
    viewController.view = self;
}

@end
