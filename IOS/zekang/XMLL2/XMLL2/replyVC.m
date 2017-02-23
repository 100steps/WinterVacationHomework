//
//  replyVC.m
//  XMLL2
//
//  Created by zzddn on 2017/2/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "replyVC.h"
#import "ThemeInfo.h"
#import "replyInfo.h"
#import "ThemeCell.h"
#import "InputView.h"
#import <PYPhotosView.h>
@interface replyVC ()<UITableViewDelegate,UITableViewDataSource,PYPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)InputView *footView;
@property (nonatomic,strong)UIButton *pictureBtn;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)PYPhotosView * postPhotosView;
@end

@implementation replyVC
- (replyInfo *)reply_info{
    if (_reply_info == nil){
        _reply_info = [replyInfo new];
    }
    return _reply_info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.replyTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320,568 - 44 ) style:UITableViewStyleGrouped];
    self.replyTV.delegate =self;
    self.replyTV.dataSource = self;
    [self.replyTV registerClass:[ThemeCell class] forCellReuseIdentifier:@"reply"];
    [self.reply_info fetch_reply_with_bar_name:self.themeInfo.bar_name and_post_id:self.themeInfo.post_id andVC:self and:self.replyTV];
    [self startAnimation];
    

}
- (void)setupView{
    if (self.footView == nil){
    //底部栏目
    self.footView = [[InputView alloc]initWithFrame:CGRectMake(0, 528, 320, 40)];
    self.footView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    self.footView.layer.borderWidth = 0.8f;
    [self.view addSubview:self.footView];
    
    //底部的添加图片的按钮
    self.pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pictureBtn setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
    self.pictureBtn.frame = CGRectMake(5, 10, 20, 20);
    [self.pictureBtn addTarget:self action:@selector(uploadPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.pictureBtn];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.frame = CGRectMake(275, 5, 40, 30);
    [self.sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.sendBtn];
    //添加观察键盘弹出的观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
    
  
    //创建添加图片页面
    PYPhotosView *postPhotosView = [PYPhotosView photosView];
    postPhotosView.delegate = self;
    postPhotosView.images = nil;
    postPhotosView.py_x = 10;
    postPhotosView.py_y = [UIScreen mainScreen].bounds.size.height + 1;
    postPhotosView.py_width = 300;
    [self.view addSubview:postPhotosView];
    self.postPhotosView = postPhotosView;
    }
    }
- (void)sendAction{
    if ([self.footView.inputTextView.text isEqual:@""]){
        [self createAlertViewWithTitle:@"不准发送!" andMessage:@"不写点什么吗？" andActionTitle1:@"遵命！" andActionTtile2:nil];
        return;
    }
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!dic[@"used"]){
        [self createAlertViewWithTitle:@"失败" andMessage:@"你还没有登录呢" andActionTitle1:@"奴才马上去登录～" andActionTtile2:nil];
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replyOver) name:@"replySendOver" object:nil];
    [self.reply_info postAReplyWithContent:self.footView.inputTextView.text andBar_name:self.themeInfo.bar_name andUser_name:dic[@"user"] andTheme_post_id:self.themeInfo.post_id andvc:self andPictures:self.postPhotosView.images];
    self.footView.inputTextView.text = @"";
    [self startAnimation];
    [self.footView.inputTextView resignFirstResponder];
}
- (void)replyOver{
    [self.view.layer removeAllAnimations];
    [self.reply_info fetch_reply_with_bar_name:self.themeInfo.bar_name and_post_id:self.themeInfo.post_id andVC:self and:self.replyTV];
}
- (void)uploadPicture{
    [self.footView.inputTextView resignFirstResponder];
    CGRect frame = self.footView.frame;
    frame.origin.y = 528 - 70 -1;
  [UIView animateWithDuration:0.4 animations:^{
      self.footView.frame = frame;
      self.postPhotosView.py_y = 568 - 70;
  }];
}
- (void)didSwipeUpOrDown{
    if (self.footView!= nil){
        [self.footView.inputTextView resignFirstResponder];
        if (self.footView.frame.origin.y != 528){
            CGRect frame = self.footView.frame;
            frame.origin.y = 528;
            [UIView animateWithDuration:0.4 animations:^{
                self.footView.frame = frame;
                self.postPhotosView.py_y = 569;
            }];
        }
    }
    
}
- (void)keyboardAppear:(NSNotification *)noti{
    //CGRect rec = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.footView.frame;
    frame.origin.y = 275;
    [UIView animateWithDuration:0.4 animations:^{
        self.footView.frame = frame;
        self.postPhotosView.py_y = 569;
    }];
}
- (void)keyboardDismiss:(NSNotification *)noti{
    CGRect frame = self.footView.frame;
    frame.origin.y = 528;
    [UIView animateWithDuration:0.4 animations:^{
        self.footView.frame = frame;
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reply_info.replyArr.count + 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reply" forIndexPath:indexPath];
    cell.autoResize = 1;
    NSIndexPath *currentIndexPath = [tableView indexPathForRowAtPoint:cell.center];
    cell.currentRow = currentIndexPath.row;
    cell.originalRow = indexPath.row;
    if (indexPath.row == 0){
        cell.themeInfo = self.themeInfo;
    }else{
    cell.reply_info = self.reply_info.replyArr[indexPath.row - 1];
    }
    return cell;
}
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    //判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        return;
    }
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    //设置打开照片相册类型
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //判断images是否为空，为空就创建一个数组
    NSMutableArray *arr;
    if  (self.postPhotosView.images == nil){
        arr = [NSMutableArray array];
    }else{
        arr = self.postPhotosView.images;
    }
    //把选到的相片加到数组里边
    [arr addObject:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.postPhotosView reloadDataWithImages:arr];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果传过去的其实只是第一个页面的主题帖子
    if (indexPath.row == 0){
       CGSize size = [self getHeightText:self.themeInfo.content andFontsize:15 andMAXheight:MAXFLOAT];
        NSInteger rowCount = [self.themeInfo getPicturesCount];
        if (rowCount == 0){return 21 + 49 + size.height + 20; }
        if (rowCount == 1){return 21 + 49 + size.height + 70 + 20;}
        if (rowCount == 2){return 21 + 49 + size.height + 70 * 2 + 20;}
        if (rowCount == 3){return 21 + 49 + size.height + 70 * 3 + 20;}
    }
    //如果是reply的话
    replyInfo *reply = self.reply_info.replyArr[indexPath.row - 1];
   CGSize size =  [self getHeightText:reply.content andFontsize:15 andMAXheight:MAXFLOAT];
   NSInteger rowCount =  [reply getPicturesCount];
    if (rowCount == 0){
        return 21 + size.height + 10 + 10 + 10;
    }
        if (rowCount == 1){return 21+ size.height + 10 + 10 + 70 + 10;}
        if (rowCount == 2){return 21+ size.height + 10 + 70 *2 + 10 + 10;}
        if (rowCount == 3){return 21+ size.height + 10 + 70 *3 + 10 + 10;}
    return  21+ size.height + 10 + 10 + 70;
}
- (CGSize)getHeightText:(NSString *)text andFontsize:(CGFloat)fontsize andMAXheight:(CGFloat)max_height{
    NSDictionary *attribute = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:fontsize]
                                };
    CGSize size = [text boundingRectWithSize:CGSizeMake(250, max_height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self didSwipeUpOrDown];
}
- (void)startAnimation{
    
    //重用层
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.position = self.view.center;
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    //点动画层
    CALayer *dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.position = CGPointMake(replicatorLayer.frame.size.width /3 /2 , replicatorLayer.frame.size.height/2 );
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = 7.5;
    dotLayer.transform = CATransform3DMakeScale(0, 0, 0);
    [replicatorLayer addSublayer:dotLayer];
    
    //设置重用点实例的个数，和转换方式
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorLayer.frame.size.width/3, 0, 0);
    
    //添加缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:animation forKey:nil];
    
    //设置点实例间动画的延迟
    replicatorLayer.instanceDelay = 1.0/3;
    
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
@end
