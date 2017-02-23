//
//  registerAndLogin.m
//  XMLL2
//
//  Created by zzddn on 2017/2/19.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "registerAndLogin.h"
#import <AFHTTPSessionManager.h>
@implementation registerAndLogin
static registerAndLogin *RAL;
+ (instancetype)shared{
    //单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RAL = [[registerAndLogin alloc]init];
    });
    return RAL;
}
- (void)registerWithName:(NSString *)user_name password:(NSString *)user_password avatar:(NSData *)user_avatar{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"user_name":user_name,
                          @"user_password":user_password
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/BosClient.php?action=register" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (user_avatar != nil){
        [formData appendPartWithFileData:user_avatar name:@"user_avatar" fileName:user_name mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"reason"]){
            self.reason = responseObject[@"reason"];
            self.result = responseObject[@"result"];
        }else{
            self.result = responseObject[@"result"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.connectError = error;
    }];
}
- (void)loginWithName:(NSString *)user_name password:(NSString *)user_password{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"user_name":user_name,
                          @"user_password":user_password
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/BosClient.php?action=login" parameters:dic constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"reason"]){
            self.reason = responseObject[@"reason"];
            self.result = responseObject[@"result"];
        }else{
            self.result = responseObject[@"result"];
            if (![responseObject[@"url"] isEqualToString:@""]){
                self.urlStr = responseObject[@"url"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.connectError = error;
    }];
}
@end
