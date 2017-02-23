//
//  BarInfo.h
//  XMLL2
//
//  Created by zzddn on 2017/2/20.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarInfo : NSObject
@property (nonatomic,copy)NSString *bar_name;
@property (nonatomic,copy)NSString *bar_totalFollow;
@property (nonatomic,copy)NSString *bar_totalPost;
@property (nonatomic,copy)NSString *bar_avatar;
@property (nonatomic,strong)NSMutableArray *infoArray;
/**
 用kvc给帖子总数、帖吧总的关注数、贴吧头像赋值

 @param dic 字典
 @return 实例
 */
+ (instancetype)barInfoWithDic:(NSDictionary *)dic;

- (void)fetchBarInfo;
@end
