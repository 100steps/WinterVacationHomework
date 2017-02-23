//
//  ThemeInfo.h
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeInfo : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *post_time;
@property (nonatomic)NSInteger post_id;
@property (nonatomic)NSInteger post_number;
@property (nonatomic,copy)NSString *pictures;
@property (nonatomic,copy)NSString *thumbnails;
@property (nonatomic,copy)NSString *bar_name;
@property (nonatomic,strong)NSMutableArray *themeArr;
/**
 获取到某个贴吧下所有的主题帖

 @param bar_name 贴吧名字
 */
- (void)fetch_theme_post:(NSString *)bar_name;

/**
 发布主题贴方法

 @param bar_name 贴吧的名字
 @param user_name 用户的名字
 @param pictures 发布所带的图片数组
 @param title 帖子标题
 @param content 帖子内容
 */
- (void)post_theme_post:(NSString *)bar_name user_name:(NSString *)user_name pictureArr:(NSArray *)pictures title:(NSString *)title content:(NSString *)content;
- (NSInteger)getPicturesCount;
@end
