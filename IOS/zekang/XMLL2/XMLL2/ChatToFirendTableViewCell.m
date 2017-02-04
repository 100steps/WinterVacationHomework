//
//  ChatToFirendTableViewCell.m
//  XMLL2
//
//  Created by zzddn on 2017/1/27.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "ChatToFirendTableViewCell.h"

@implementation ChatToFirendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //初始化头像imageView
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.layer.cornerRadius = 20.0f;
        self.headImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.headImageView];
        
        //气泡框
        self.backView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.backView];
        
        //文本标签
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.backView addSubview:self.contentLabel];
        
        //背景色
        self.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
        
    }
    return self;
}

-(void)refleshCellWithMessage:(NSString *)message andHeaderView:(UIImage *)header andGetFromFriend:(BOOL)get{
    UIImage *image = nil;
    UIImage *headerImage = nil;
    //计算文本长度
    CGRect rec = [message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/14*9, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    if (get){
        self.headImageView.frame = CGRectMake(10, 2, 40, 40);
        self.backView.frame = CGRectMake(60, 2, rec.size.width + 20, 40);
        headerImage = header;
        image = [UIImage imageNamed:@"收到气泡"];
    }else{
        self.headImageView.frame = CGRectMake(320 - 50, 2, 40, 40);
        self.backView.frame = CGRectMake(320 - 60 - rec.size.width - 20, 2, rec.size.width + 20, 40);
        image = [UIImage imageNamed:@"发送气泡"];
        headerImage = header;
    }
    self.headImageView.image = headerImage;
    self.backView.image = image;
    self.contentLabel.frame = CGRectMake(10, (40 - rec.size.height) / 2, rec.size.width, rec.size.height);
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.text = message;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
