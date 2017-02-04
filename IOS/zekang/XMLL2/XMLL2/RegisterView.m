//
//  RegisterView.m
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "RegisterView.h"
@implementation RegisterView
- (UITextField *)userName{
    if (_userName == nil){
        _userName = [[UITextField alloc]initWithFrame:CGRectMake(25, 120, 320 - 50, 50)];
        
        //设置左边图像
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImage *image = [UIImage imageNamed:@"用户"];
        imageView.image = image;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [leftView addSubview:imageView];
        imageView.center = leftView.center;
        [_userName setLeftView:leftView];
        _userName.leftViewMode = UITextFieldViewModeAlways;
        [_userName setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        //设置文本框
        _userName.backgroundColor = [UIColor whiteColor];
        _userName.layer.borderWidth = 0.8f;
        _userName.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]);
        _userName.placeholder = @"账号";
    }
    return _userName;
}
- (UITextField *)passWord{
    if (_passWord == nil){
        _passWord = [[UITextField alloc]initWithFrame:CGRectMake(25, 171, 320 - 50, 50)];
        
        //设置左边图像
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImage *image = [UIImage imageNamed:@"注册密码"];
        imageView.image = image;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [leftView addSubview:imageView];
        imageView.center = leftView.center;
        [_passWord setLeftView:leftView];
        _passWord.leftViewMode = UITextFieldViewModeAlways;
        [_passWord setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        //设置文本框
        _passWord.backgroundColor = [UIColor whiteColor];
        _passWord.layer.borderWidth = 0.8f;
        _passWord.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]);
        _passWord.placeholder = @"密码";
        _passWord.secureTextEntry = YES;
    }
    return _passWord;
}
- (UITextField *)passWordAg{
    if (_passWordAg == nil){
        _passWordAg = [[UITextField alloc]initWithFrame:CGRectMake(25, 222, 320 - 50, 50)];
        
        //设置左边图像
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImage *image = [UIImage imageNamed:@"确认密码"];
        imageView.image = image;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [leftView addSubview:imageView];
        imageView.center = leftView.center;
        [_passWordAg setLeftView:leftView];
        _passWordAg.leftViewMode = UITextFieldViewModeAlways;
        [_passWordAg setClearButtonMode:UITextFieldViewModeWhileEditing];
        //设置文本框
        _passWordAg.backgroundColor = [UIColor whiteColor];
        _passWordAg.layer.borderWidth = 0.8f;
        _passWordAg.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]);
        _passWordAg.placeholder = @"确认密码";
        _passWordAg.secureTextEntry = YES;
    }
    return _passWordAg;
}
- (UIButton *)registerBtn{
    if (_registerBtn == nil){
        _registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 292, 320 - 50, 50)];
        [_registerBtn setTintColor:[UIColor whiteColor]];
        _registerBtn.backgroundColor = [UIColor grayColor];
        _registerBtn.layer.cornerRadius = 4;
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.enabled = NO;
        _registerBtn.showsTouchWhenHighlighted = YES;
    }
    return _registerBtn;
}
- (void)ViewAddTo:(UIViewController *)viewController andTitle:(NSString *)title{
    [self addSubview:self.userName];
    [self addSubview:self.passWord];
    //如果是注册，则不加载确认密码框
    if ([title isEqualToString:@"注册"]) { [self addSubview:self.passWordAg];}
    [self addSubview:self.registerBtn];
    self.backgroundColor =  [UIColor colorWithRed:240/255.0 green:240/255.0     blue:240/255.0 alpha:1.0];
    viewController.view = self;
    
    //上滑手势判断
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(notifySwipeUp)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:recognizer];
    
    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextFieldDidChang) name:UITextFieldTextDidChangeNotification object:self.userName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextFieldDidChang) name:UITextFieldTextDidChangeNotification object:self.passWord];
    if ([title isEqualToString:@"注册"]){ [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextFieldDidChang) name:UITextFieldTextDidChangeNotification object:self.passWordAg]; }
}
- (void)notifySwipeUp{
    if ([self.delegate respondsToSelector:@selector(swipeUp:)]){
        [_delegate swipeUp:self];
    }
}
- (void)notifyTextFieldDidChang{
    if ([self.delegate respondsToSelector:@selector(TextFieldDidChang:)]){
        [_delegate TextFieldDidChang:self];
    }
}
@end
