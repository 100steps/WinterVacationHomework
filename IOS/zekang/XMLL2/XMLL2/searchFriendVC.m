//
//  searchFriendVC.m
//  XMLL2
//
//  Created by zzddn on 2017/2/5.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "searchFriendVC.h"
#import "XMPPStreamManager.h"
@interface searchFriendVC ()
@property (nonatomic,strong)UITextField *addNameField;
@end

@implementation searchFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //文本框
    self.view.backgroundColor = [UIColor whiteColor];
    _addNameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 70, 320- 60 - 20, 50)];
    _addNameField.placeholder = @"新朋友的用户名";
    _addNameField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_addNameField];
    //添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTintColor:[UIColor blackColor]];
    button.frame = CGRectMake(320 - 50, 70, 50, 50);
    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
- (void)buttonDidClick{
    XMPPJID *jid = [XMPPJID jidWithUser:self.addNameField.text domain:@"192.168.1.102" resource:nil];
    [[XMPPStreamManager sharedManager].roster subscribePresenceToUser:jid];
    [self dismissViewControllerAnimated:YES completion:nil];
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
