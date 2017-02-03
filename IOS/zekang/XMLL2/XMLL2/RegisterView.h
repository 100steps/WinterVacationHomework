//
//  RegisterView.h
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterView;
@protocol RegisterViewDelegate <NSObject>
@optional
//一个代理方法，在有上滑手势的时候会调用
- (void)swipeUp:(RegisterView *)view;
//在用户名和密码文本变化时会被调用
- (void)TextFieldDidChang:(RegisterView *)view;
@end
@interface RegisterView : UIView
@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *passWord;
@property (nonatomic,strong)UITextField *passWordAg;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,weak)id<RegisterViewDelegate>delegate;
- (void)ViewAddTo:(UIViewController *)viewController andTitle:(NSString *)title;

@end
