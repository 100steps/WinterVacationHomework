//
//  replyVC.h
//  XMLL2
//
//  Created by zzddn on 2017/2/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeInfo;
@class replyInfo;
@interface replyVC : UIViewController
@property (nonatomic,strong)ThemeInfo *themeInfo;
@property (nonatomic,strong)replyInfo *reply_info;
@property (nonatomic,strong)UITableView *replyTV;
- (void)setupView;
@end
