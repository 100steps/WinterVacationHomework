//
//  RegisterViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//
#import "RegisterViewController.h"
#import "RegisterView.h"
#import "XMPPStreamManager.h"
#import "registerAndLogin.h"
@interface RegisterViewController ()<RegisterViewDelegate>
@property (nonatomic,strong)UIActivityIndicatorView *indicator;
@property (nonatomic,weak)NSTimer *timer;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,strong)RegisterView *registerView;
@end

@implementation RegisterViewController
- (void)loadView{
    //根据导航条的title来部署view
    self.registerView = [[RegisterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.registerView ViewAddTo:self andTitle:self.navigationItem.title];
    _registerView.delegate = self;
}
//懒加载
- (UIActivityIndicatorView *)indicator{
    if (_indicator == nil){
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.color = [UIColor blueColor];
    _indicator.hidesWhenStopped = YES;
    _indicator.center = CGPointMake(160, 260);
    [self.view addSubview:_indicator];
    }
    _indicator.hidden = NO;
    return _indicator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //根据导航条的title来部署按钮的title，以便一下步调用
    [_registerView.registerBtn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    
    //添加按钮的响应事件
    [_registerView.registerBtn addTarget:self action:@selector(startRegister2) forControlEvents:UIControlEventTouchUpInside];
    
    //KVO模式，添加观察者
    [[registerAndLogin shared] addObserver:self forKeyPath:@"result" options:NSKeyValueObservingOptionNew context:nil];
    [[registerAndLogin shared] addObserver:self forKeyPath:@"connectError" options:NSKeyValueObservingOptionNew context:nil];
}
//-------------------------------------------------------//
#pragma mark -- 提交事件 核心事件 要用后端接口，这个就不调用了
- (void)startRegister{
    //在每次开始登录或者注册前都要断开连接一下,因为连接成功后的一个代理方法只会调用一次
    [[XMPPStreamManager sharedManager].xmppStream disconnect];
    XMPPJID *myJID =  [XMPPJID jidWithUser:_registerView.userName.text domain:@"192.168.1.102" resource:nil];
    
    //空格字符检测
    if([self spaceCheck:_registerView.passWord.text] || [self spaceCheck:_registerView.userName.text] ){ return; }
    
    //如果是注册，则进行密码相同检验
    if ([self.navigationItem.title isEqualToString:@"注册"]){
        if (![self passwordCheck:_registerView.passWord.text andPasswordAg:_registerView.passWordAg.text]){
            return;
        }
    }
    //无论是登录还是注册都调用这个方法
  [[XMPPStreamManager sharedManager] loginToServerWithJID:myJID andPassword:_registerView.passWord.text andTitle:self.navigationItem.title];
    
    //设置定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(checkConnect) userInfo:nil repeats:NO];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNoti:) name:@"connect" object:nil];
    
    //加载指示器
    [self.indicator startAnimating];
  
    //转动的时候用户交互关闭
    [self.view setUserInteractionEnabled:NO];
    
    //隐藏返回button
    self.navigationItem.hidesBackButton =YES;
    }
//-------------------------------------------------------//
#pragma mark -- 改用这个
- (void)startRegister2{
    //空白检测
    if ([self spaceCheck:_registerView.passWord.text] || [self spaceCheck:_registerView.userName.text]){ return;}
    //密码相同检测
    if ([self.navigationItem.title isEqualToString:@"注册"]){
        if (![self passwordCheck:_registerView.passWord.text andPasswordAg:_registerView.passWordAg.text]){
            return;
        }
        [self.indicator startAnimating];
        [[registerAndLogin shared] registerWithName:_registerView.userName.text password:_registerView.passWord.text avatar:nil];
    }else{
        [self.indicator startAnimating];
        [[registerAndLogin shared] loginWithName:_registerView.userName.text password:_registerView.passWord.text];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"result"]){
        if ([change[NSKeyValueChangeNewKey] isEqualToString:@"false"]){
            [self createAlertViewWithTitle:@"连接失败" andMessage:[registerAndLogin shared].reason andActionTitle1:@"我知道了" andActionTtile2:nil];
            self.indicator.hidden = YES;
        }else if ([change[NSKeyValueChangeNewKey] isEqualToString:@"success"]){
            //移除指示器
            self.indicator.hidden = YES;
            [self.indicator removeFromSuperview];
            
            //保存登录成功的用户名和密码
            NSString *path =[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:_registerView.userName.text forKey:@"user"];
            [dic setObject:_registerView.passWord.text forKey:@"password"];
            [dic setObject:@1 forKey:@"used"];
            [dic writeToFile:path atomically:NO];
            
            //切换window
            [self.view.window resignKeyWindow];
            self.view.window.hidden = YES;
        }
    }else if ([keyPath isEqualToString:@"connectError"]){
        [self createAlertViewWithTitle:@"错误" andMessage:@"请检查你的网络连接" andActionTitle1:@"嗯好滴" andActionTtile2:nil];
        self.indicator.hidden = YES;
    }
}
//空格字符检测方法
- (BOOL)spaceCheck:(NSString *)string{
    NSRange range = [string rangeOfString:@" "];
    if (range.location != NSNotFound){
        [self createAlertViewWithTitle:@"提交失败" andMessage:@"含有空格字符" andActionTitle1:@"我知道了" andActionTtile2:nil];
        return YES;
    }
    return NO;
}

//两次输入密码相同检查
- (BOOL)passwordCheck:(NSString *)password andPasswordAg:(NSString *)passwordAg{
    if (password != passwordAg){
        [self createAlertViewWithTitle:@"提交失败" andMessage:@"两次输入的密码不同" andActionTitle1:@"我知道了" andActionTtile2:nil];
        return NO;
    }
    return YES;
}
- (void)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message andActionTitle1:(NSString * _Nonnull)title1 andActionTtile2:(NSString *)title2{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action1];
    if (title2 != nil){
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action2];
    }
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)checkConnect{
    //对指示器的处理
    [self.indicator stopAnimating];
    //对计时器的处理
    [self.timer invalidate];
    self.timer = nil;
    //给回用户交互
    [self.view setUserInteractionEnabled:YES];
    if (_status != nil){
        if ([_status isEqual:@"成功认证"]){
#pragma mark --动画效果下次加吧
            [self.view setUserInteractionEnabled:NO];
//            UIImage *image = [UIImage imageNamed:@"success2"];
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//            imageView.frame = CGRectMake(0, 0, 60, 60);
//            imageView.center = self.indicator.center;
//            imageView.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:137.0/255.0 blue:195.0/255.0 alpha:0.9];
//            imageView.layer.cornerRadius = 4;
//            [imageView.layer masksToBounds];
//            [self.view addSubview:imageView];
            
            [NSThread sleepForTimeInterval:1];
            
            //保存登录成功的用户名和密码
         NSString *path =[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:_registerView.userName.text forKey:@"user"];
            [dic setObject:_registerView.passWord.text forKey:@"password"];
            [dic setObject:@1 forKey:@"used"];
            [dic writeToFile:path atomically:NO];
            
            //切换window
            [self.view.window resignKeyWindow];
            self.view.window.hidden = YES;
        }else{
    UIAlertController *controller = [UIAlertController  alertControllerWithTitle:@"出错啦！" message:_status preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
        self.navigationItem.hidesBackButton = NO;
        }
    }else{
    UIAlertController *controller = [UIAlertController  alertControllerWithTitle:@"出错啦！" message:@"可能是服务器没上线，联系泽康看看" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我会联系的" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
        self.navigationItem.hidesBackButton = NO;
    }
}

- (void)didReceiveNoti:(NSNotification *)noti{
    self.status = noti.userInfo[@"status"];
}

- (void)TextFieldDidChang:(RegisterView *)view{
    if (_registerView.userName.hasText && _registerView.passWord.hasText ) {
        if ([self.navigationItem.title isEqualToString:@"登录"] || _registerView.passWordAg.hasText ){
        _registerView.registerBtn.enabled = YES;
        _registerView.registerBtn.backgroundColor = [UIColor orangeColor];
        }else{
        _registerView.registerBtn.enabled = NO;
        _registerView.registerBtn.backgroundColor = [UIColor grayColor];
        }
    }else{
        _registerView.registerBtn.enabled = NO;
        _registerView.registerBtn.backgroundColor = [UIColor grayColor];
    }
}

- (void)swipeUp:(RegisterView *)view{
    //释放键盘
    [_registerView.userName resignFirstResponder];
    [_registerView.passWord resignFirstResponder];
    [_registerView.passWordAg resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
     CGPoint point = [touch locationInView:self.view];
    if (!(point.x >50 && point.x < 270 && point.y>120 && point.y <222 )){
        [_registerView.userName resignFirstResponder];
        [_registerView.passWord resignFirstResponder];
        [_registerView.passWordAg resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated{
    //页面将消失时，释放一下键盘
    [_registerView.userName resignFirstResponder];
    [_registerView.passWord resignFirstResponder];
    [_registerView.passWordAg resignFirstResponder];
    
    //清空文本
    _registerView.userName.text = @"";
    _registerView.passWord.text = @"";
    _registerView.passWordAg.text = @"";
    _registerView.registerBtn.enabled = NO;
    _registerView.registerBtn.backgroundColor = [UIColor grayColor];
    
}
- (void)viewWillAppear:(BOOL)animated{
    if (_registerView.subviews.count >= 4 && [self.navigationItem.title isEqualToString:@"登录"]){
        [_registerView.passWordAg removeFromSuperview];
    }
}
- (void)dealloc{
    [[registerAndLogin shared] removeObserver:self forKeyPath:@"result"];
    [[registerAndLogin shared] removeObserver:self forKeyPath:@"connectError"];
}
@end
