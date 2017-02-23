//
//  ThemeCell.m
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "ThemeCell.h"
#import "ThemeInfo.h"
#import "replyInfo.h"
#import <PYPhotoBrowser.h>
@interface ThemeCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *avatarView;
@property (nonatomic,strong)PYPhotosView *photosView;
@property (nonatomic,strong)UILabel *timeLabel;
@end
@implementation ThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setReply_info:(replyInfo *)reply_info{
    _reply_info = reply_info;
    //设置头像
    self.avatarView.image = [UIImage imageNamed:@"占位图"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@  %ld楼",reply_info.user_name,(long)reply_info.post_number];
    CGSize size2;
    size2 = [self getHeightText:reply_info.content andFontsize:15 andMAXheight:MAXFLOAT];
    self.contentLabel.frame = CGRectMake(60, 21, 250,size2.height);
    self.contentLabel.text = reply_info.content;
    self.contentLabel.textColor = [UIColor grayColor];
    
    //设置时间label
    self.timeLabel.text = reply_info.post_time;
    //获取行数
    NSInteger rowCount =  [reply_info getPicturesCount];
    if (rowCount == 0){
        self.timeLabel.frame = CGRectMake(175, 21 + size2.height +10, 135, 15);
    }
    if (rowCount == 1){
        self.timeLabel.frame = CGRectMake(175, 21 + size2.height + 70 + 10, 135, 15);
    }
    if (rowCount == 2){
        self.timeLabel.frame = CGRectMake(175, 21 + size2.height + 70 *2 + 10, 135, 15);
    }
    if (rowCount == 3){
        self.timeLabel.frame = CGRectMake(175, 21 + size2.height + 70 *3 + 10, 135, 15);
    }
    self.photosView.originalUrls =nil;
    self.photosView.thumbnailUrls = nil;
    [self.photosView removeFromSuperview];
    self.photosView = nil;
    if (self.currentRow != self.originalRow){
        return;
    }
    //照片为0行，就不设置了
    if (rowCount == 0){return;}
    //photosView的设置
    self.photosView = [PYPhotosView photosView];
    self.photosView.py_x = 60;
    self.photosView.py_y = 21 + size2.height +2 + 8;
    
    NSRange range = [reply_info.thumbnails rangeOfString:@","];
    //起码是两个以上的url;
    if (range.location != NSNotFound){
        NSArray *thumbnailsArray = [reply_info.thumbnails componentsSeparatedByString:@","];
        NSArray *photosArray = [reply_info.pictures componentsSeparatedByString:@","];
        self.photosView.thumbnailUrls = thumbnailsArray;
        self.photosView.originalUrls = photosArray;
        self.photosView.pageType = PYPhotosViewPageTypeLabel;
    }else{
        //只有一个url
        NSArray *thumbnailsArray = [NSArray arrayWithObject:reply_info.thumbnails];
        NSArray *photosArray = [NSArray arrayWithObject:reply_info.pictures];
        self.photosView.thumbnailUrls = thumbnailsArray;
        self.photosView.originalUrls = photosArray;
        self.photosView.pageType = PYPhotosViewPageTypeLabel;
    }
    [self.contentView addSubview:self.photosView];
}

- (void)setThemeInfo:(ThemeInfo *)themeInfo{
    _themeInfo = themeInfo;
    //设置头像
    self.avatarView.image = [UIImage imageNamed:@"占位图"];
   CGSize size = [self getHeightText:themeInfo.title andFontsize:19 andMAXheight:49];
    self.titleLabel.frame =CGRectMake(60, 21, 250, size.height);
    self.titleLabel.text = themeInfo.title;
    CGSize size2;
    if (self.autoResize != 1){ size2 = [self getHeightText:themeInfo.content andFontsize:15 andMAXheight:36];
         self.nameLabel.text = themeInfo.user_name;
    }else{
        size2 = [self getHeightText:themeInfo.content andFontsize:15 andMAXheight:MAXFLOAT];
        self.contentLabel.numberOfLines = 0;
        self.nameLabel.text = [NSString stringWithFormat:@"%@  楼主",themeInfo.user_name];
    }
    self.contentLabel.frame = CGRectMake(60, 21 + size.height + 5, 250,size2.height);
    self.contentLabel.text = themeInfo.content;
    self.contentLabel.textColor = [UIColor grayColor];
    //设置时间
    self.timeLabel.text = themeInfo.post_time;
    
    //获取图片行数
    NSInteger rowCount = [themeInfo getPicturesCount];
    if (rowCount == 0){
    self.timeLabel.frame = CGRectMake(175, 21 + size.height +5 + size2.height +5 , 135, 15);
    }
    if (rowCount == 1){
    self.timeLabel.frame = CGRectMake(175, 21 + size.height + 5 + size2.height + 5 + 70 , 135, 15);
    }
    if (rowCount == 2){
    self.timeLabel.frame = CGRectMake(175, 21 + size.height + 5 + size2.height + 5 + 70 * 2, 135, 15);
    }
    if (rowCount == 3){
        self.timeLabel.frame = CGRectMake(175, 21 + size.height + 5 + size2.height + 5 + 70 * 3,135,15);
    }
   //移除原有的图片
    self.photosView.originalUrls =nil;
    self.photosView.thumbnailUrls = nil;
    [self.photosView removeFromSuperview];
    self.photosView = nil;
    
    if (self.currentRow != self.originalRow){
        return;
    }
    
    if (rowCount == 0){return; }
    
    //photosView的设置
    self.photosView = [PYPhotosView photosView];
    self.photosView.py_x = 60;
    self.photosView.py_y = 21 + size.height + 5 + size2.height + 5;
    NSRange range = [themeInfo.thumbnails rangeOfString:@","];
    //起码是两个以上的url;
    if (range.location != NSNotFound){
        NSArray *thumbnailsArray = [themeInfo.thumbnails componentsSeparatedByString:@","];
        NSArray *photosArray = [themeInfo.pictures componentsSeparatedByString:@","];
        self.photosView.thumbnailUrls = thumbnailsArray;
        self.photosView.originalUrls = photosArray;
        self.photosView.pageType = PYPhotosViewPageTypeLabel;
    }else{
        //只有一个url
         NSArray *thumbnailsArray = [NSArray arrayWithObject:themeInfo.thumbnails];
        NSArray *photosArray = [NSArray arrayWithObject:themeInfo.pictures];
        self.photosView.thumbnailUrls = thumbnailsArray;
        self.photosView.originalUrls = photosArray;
        self.photosView.pageType = PYPhotosViewPageTypeLabel;
    }
      [self.contentView addSubview:self.photosView];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //左边头像的设置
        self.avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50,50)];
        self.avatarView.layer.cornerRadius = 25.0f;
        self.avatarView.clipsToBounds = YES;
        [self.contentView addSubview:self.avatarView];
        
        //user_name的设置
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 250, 15)];
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.numberOfLines = 1;
        [self.contentView addSubview:self.nameLabel];
        
        //titleLabel的设置
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:self.titleLabel];
        
        //contentLabel的设置
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.tintColor = [UIColor grayColor];
        [self.contentView addSubview:self.contentLabel];
        
        //时间label的设置
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (CGSize)getHeightText:(NSString *)text andFontsize:(CGFloat)fontsize andMAXheight:(CGFloat)max_height{
    NSDictionary *attribute = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:fontsize]
                                };
    CGSize size = [text boundingRectWithSize:CGSizeMake(250, max_height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
