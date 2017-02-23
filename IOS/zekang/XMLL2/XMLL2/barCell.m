//
//  barCell.m
//  XMLL2
//
//  Created by zzddn on 2017/2/20.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "barCell.h"
#import "BarInfo.h"
#import <UIImageView+WebCache.h>
@interface barCell()
@property (nonatomic,strong)UIImageView *bar_avatar;
@property (nonatomic,strong) UILabel *bar_name;
@property (nonatomic,strong) UILabel *bar_message;
@property (nonatomic,strong)UIImageView *backView;
@end
@implementation barCell
- (void)setBarInfo:(BarInfo *)barInfo{
    _barInfo = barInfo;
    self.bar_name.text = barInfo.bar_name;
    self.bar_message.text = [NSString stringWithFormat:@"关注:%@ 帖子:%@",barInfo.bar_totalFollow,barInfo.bar_totalPost];
    [self.bar_name sizeToFit];
    [self.bar_message sizeToFit];
    if (![barInfo.bar_avatar isEqual:[NSNull null]]){
    [self.bar_avatar sd_setImageWithURL:[NSURL URLWithString:barInfo.bar_avatar]];
    }else{
        self.bar_avatar.image = [UIImage imageNamed:@"test.jpg"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.bar_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
        self.bar_avatar.layer.borderWidth = 0.8f;
        self.bar_avatar.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.bar_avatar];
        
        self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(90, 5, 200, 80)];
        [self.contentView addSubview:self.backView];
        
        self.bar_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.bar_name.numberOfLines = 0;
        [self.backView addSubview:self.bar_name];
        
        self.bar_message = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 200, 25)];
        self.bar_message.numberOfLines = 0;
        [self.backView addSubview:self.bar_message];
    
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
