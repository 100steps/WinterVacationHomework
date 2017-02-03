//
//  FirstUseView.h
//  XMLL2
//
//  Created by zzddn on 2017/1/22.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstUseView : UIView
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *loginBtn;
- (void)viewAddTo:(UIViewController *)viewController;
@end
