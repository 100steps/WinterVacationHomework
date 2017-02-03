//
//  ChatToFirendTableViewCell.h
//  XMLL2
//
//  Created by zzddn on 2017/1/27.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatToFirendTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *backView;
@property (nonatomic,strong) UILabel *contentLabel;
-(void)refleshCellWithMessage:(NSString *)message andHeaderView:(UIImage *)header andGetFromFriend:(BOOL)get;
@end

