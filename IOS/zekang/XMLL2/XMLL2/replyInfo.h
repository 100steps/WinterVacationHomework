//
//  replyInfo.h
//  XMLL2
//
//  Created by zzddn on 2017/2/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
@interface replyInfo : NSObject
@property (nonatomic,copy)NSString *bar_name;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *post_time;
@property (nonatomic,copy)NSString *pictures;
@property (nonatomic,copy)NSString *thumbnails;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *user_avatar;
@property (nonatomic)NSInteger post_id;
@property (nonatomic)NSInteger post_number;
@property (nonatomic,copy)NSString *theme_post_id;

@property (nonatomic,strong)NSMutableArray *replyArr;
/**
 获取回复帖方法

 @param bar_name 贴吧的名字
 @param post_id 该主题帖的id
 */
- (void)fetch_reply_with_bar_name:(NSString *)bar_name and_post_id:(NSInteger)post_id andVC:(UIViewController *)replyVC2 and:(UITableView *)TV;
- (NSInteger)getPicturesCount;

/**
 这是发送一个回复帖子的方法

 @param content 回复帖子的内容
 @param bar_name 吧名
 @param user_name 用户名
 @param post_id 主题帖的id
 */
- (void)postAReplyWithContent:(NSString *)content andBar_name:(NSString *)bar_name andUser_name:(NSString *)user_name andTheme_post_id:(NSInteger)post_id andvc:(UIViewController *)vc andPictures:(NSArray *)picArr;
@end
