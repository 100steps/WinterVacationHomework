//
//  ChatToFriendViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/27.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "ChatToFriendViewController.h"
#import "XMPPStreamManager.h"
#import "XMPPMessage.h"
#import "InputView.h"
@interface ChatToFriendViewController ()<UITableViewDelegate,UITableViewDataSource,XMPPStreamManagerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)InputView *inputView;
@end
@implementation ChatToFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadChatTableView];
    self.tabBarController.tabBar.hidden = YES;
    [XMPPStreamManager sharedManager].delegate = self;
    //加载inputView;
    _inputView = [[InputView alloc]initWithFrame:CGRectMake(0, 568 - 50, 320, 50)];
    [self.view addSubview:_inputView];
    
    //添加观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
    
    self.inputView.inputTextView.returnKeyType = UIReturnKeyDone;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(320 - 45, 5, 40, 40);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:button];
    
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewDidClick)];
    [self.tableView addGestureRecognizer:tap];
}
- (void)tableViewDidClick{
    [self.inputView.inputTextView resignFirstResponder];
}
- (void)keyboardAppear:(NSNotification *)noti{
    CGRect rec = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = -rec.size.height;
        self.view.frame = rect;
        self.tableView.frame = CGRectMake(0, 64 + rec.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114 - rec.size.height);
        //跟随视图到最后一行
        if (self.array.count > 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.array.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}
- (void)keyboardDismiss:(NSNotificationCenter *)noti{
    [UIView animateWithDuration:0.3 animations:^{
    self.view.frame = [UIScreen mainScreen].bounds;
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114);
    }];
}
- (void)sendMessage{
    //发送消息
    XMPPJID *jid = [XMPPJID jidWithString:[XMPPStreamManager sharedManager].chatJID];
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
    [message addBody:self.inputView.inputTextView.text];
    [[XMPPStreamManager sharedManager].xmppStream sendElement:message];

    
    //添加到数组中
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [dic setObject:self.inputView.inputTextView.text forKey:@"message"];
    [dic setObject:@"SEND" forKey:@"style"];
    [self.array addObject:dic];
    //清空文本
    self.inputView.inputTextView.text = @"";
    //刷新数据
    [self.tableView reloadData];
    //视图跟随到最后一行
    if (self.array.count > 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.array.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
- (NSMutableArray *)array{
    if (_array == nil){
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveMessage:(XMPPStreamManager *)sender andChatMessage:(NSString *)chatMessage{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [dic setObject:chatMessage forKey:@"message"];
    [dic setObject:@"GET" forKey:@"style"];
    //设置时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [dic setObject:dateTime forKey:@"time"];
    [self.array addObject:dic];
    
    //刷新数据
    [self.tableView reloadData];
   //视图跟随到最后一行
    if (self.array.count > 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.array.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
-(void)loadChatTableView{
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatToFirendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    if (cell == nil){
        cell = [[ChatToFirendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
    }
    //设置头像
    UIImage *image = [UIImage imageNamed:@"占位图"];
    
    if ([self.array[indexPath.section][@"style"] isEqual:@"GET"]){
        [cell refleshCellWithMessage:self.array[indexPath.section][@"message"] andHeaderView:image andGetFromFriend:YES];
    }else{
        [cell refleshCellWithMessage:self.array[indexPath.section][@"message"] andHeaderView:image andGetFromFriend:NO];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15.0f;
}

@end
