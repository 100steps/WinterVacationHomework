//
//  postThemeVC.m
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "postThemeVC.h"
#import "ThemeInfo.h"
#import <PYPhotosView.h>
@interface postThemeVC ()<PYPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak)PYPhotosView *postPhotosView;
@property (nonatomic,strong)UITextField *titleField;
@property (nonatomic,strong)UITextView *conentView;
@property (nonatomic,strong)UIView *footView;
@property (nonatomic,strong)UIButton *pictureBtn;
@property (nonatomic,strong)ThemeInfo *themeInfo;
@end

@implementation postThemeVC
- (ThemeInfo *)themeInfo{
    if (_themeInfo == nil){
        _themeInfo = [ThemeInfo new];
    }
    return _themeInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    //设置一些属性
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布主题贴";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipeUpOrDown)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipeUpOrDown)];
    recognizer2.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizer2];
    
    //标题文本框
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(10, 65, 300, 35)];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.placeholder = @"标题(必须)";
    self.titleField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.titleField];
    
    //内容页面
    self.conentView = [[UITextView alloc]initWithFrame:CGRectMake(10, 100 + 1, 300, 467 - 50)];
    self.conentView.layer.masksToBounds = YES;
    self.conentView.layer.cornerRadius = 5;
    self.conentView.layer.borderWidth = 1.0f;
    self.conentView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]);
    self.conentView.backgroundColor = [UIColor whiteColor];
    self.conentView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.conentView];
    
    //底部栏目
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(10, 518 + 10, 300, 30)];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.footView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    self.footView.layer.borderWidth = 0.8f;
    [self.view addSubview:self.footView];
    
    //底部的添加图片的按钮
    self.pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pictureBtn setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
    self.pictureBtn.frame = CGRectMake(5, 5, 20, 20);
    [self.pictureBtn addTarget:self action:@selector(uploadPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.pictureBtn];
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
- (void)keyboardAppear:(NSNotification *)noti{
    //获得键盘停止位置的frame值
    if (self.postPhotosView.py_y != [UIScreen mainScreen].bounds.size.height + 1){
        self.postPhotosView.py_y = [UIScreen mainScreen].bounds.size.height + 1;
    }
    //CGRect rec = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.conentView.frame;
        if (rect.size.height != 417 && rect.size.height != 417 - 80){ return;}
        rect.size.height = 417 - 253;
        self.conentView.frame = rect;
        
        CGRect footRect = self.footView.frame;
        footRect.origin.y = 528 - 253;
        self.footView.frame = footRect;
        
    }];
}
- (void)keyboardDismiss:(NSNotificationCenter *)noti{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.conentView.frame;
        rect.size.height = 417;
        self.conentView.frame = rect;
        
        CGRect footRect = self.footView.frame;
        footRect.origin.y = 528;
        self.footView.frame = footRect;
    }];
}


- (void)uploadPicture{
    if (self.postPhotosView.py_y != [UIScreen mainScreen].bounds.size.height + 1){return;}
    [self.titleField resignFirstResponder];
    [self.conentView resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        self.postPhotosView.py_y = [UIScreen mainScreen].bounds.size.height - 75;
        
        CGRect rect = self.conentView.frame;
        rect.size.height = rect.size.height - 80;
        self.conentView.frame = rect;
        
        CGRect footRect = self.footView.frame;
        footRect.origin.y = footRect.origin.y - 80;
        self.footView.frame = footRect;
        
    }];
}
- (void)didSwipeUpOrDown{
    [self.titleField resignFirstResponder];
    [self.conentView resignFirstResponder];
    if (self.postPhotosView.py_y != [UIScreen mainScreen].bounds.size.height + 1){
        self.postPhotosView.py_y = [UIScreen mainScreen].bounds.size.height + 1;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.conentView.frame;
        rect.size.height = 417;
        self.conentView.frame = rect;
        
        CGRect footRect = self.footView.frame;
        footRect.origin.y = 528;
        self.footView.frame = footRect;
    }];
    }
}
- (void)send{
    if ([self.titleField.text isEqual:@""] || [self.conentView.text isEqual:@""]){
        [self createAlertViewWithTitle:@"发送失败～" andMessage:@"写点东西再发吧" andActionTitle1:@"遵命" andActionTtile2:nil];
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!dic[@"used"]){
        [self createAlertViewWithTitle:@"失败" andMessage:@"你还没有登录呢" andActionTitle1:@"奴才马上去登录～" andActionTtile2:nil];
        return;
    }
    [self.themeInfo post_theme_post:self.bar_name user_name:dic[@"user"] pictureArr:self.postPhotosView.images.copy title:self.titleField.text content:self.conentView.text];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
    
}
@end
