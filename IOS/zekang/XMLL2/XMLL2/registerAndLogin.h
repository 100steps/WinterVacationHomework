//
//  registerAndLogin.h
//  XMLL2
//
//  Created by zzddn on 2017/2/19.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface registerAndLogin : NSObject
@property (nonatomic,copy)NSString *result;
@property (nonatomic,copy)NSString *reason;
@property (nonatomic,strong)NSError *connectError;
@property (nonatomic,copy)NSString *urlStr;
+ (instancetype)shared;

/**
 注册方法

 @param user_name 用户名
 @param user_password 用户密码
 @param user_avatar 可选,用户的头像data
 */
- (void)registerWithName:(NSString *)user_name password:(NSString *)user_password avatar:(NSData *)user_avatar;

/**
 登录方法

 @param user_name 登录的用户名
 @param user_password 登录用户的密码
 */
- (void)loginWithName:(NSString *)user_name password:(NSString *)user_password;
@end
