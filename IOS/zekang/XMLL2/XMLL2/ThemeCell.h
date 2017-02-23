//
//  ThemeCell.h
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeInfo;
@class replyInfo;
@interface ThemeCell : UITableViewCell
@property (nonatomic,weak)ThemeInfo *themeInfo;
@property (nonatomic,weak)replyInfo *reply_info;
@property (nonatomic) NSInteger autoResize;
@property (nonatomic) NSInteger currentRow;
@property (nonatomic) NSInteger originalRow;
@end
