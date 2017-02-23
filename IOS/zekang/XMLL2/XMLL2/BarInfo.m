//
//  BarInfo.m
//  XMLL2
//
//  Created by zzddn on 2017/2/20.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "BarInfo.h"
#import <AFHTTPSessionManager.h>
@implementation BarInfo
+ (instancetype)barInfoWithDic:(NSDictionary *)dic{
    BarInfo *barInfo = [self new];
    [barInfo setValuesForKeysWithDictionary:dic];
    return barInfo;
}
- (void)fetchBarInfo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    [manager GET:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/tieba.php?action=fetch" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = (NSArray *)responseObject;
        self.infoArray = [NSMutableArray arrayWithCapacity:5];
           for (NSDictionary *dic in arr) {
               BarInfo *barInfo = [BarInfo new];
               barInfo.bar_name = dic[@"bar_name"];
               barInfo.bar_avatar = dic[@"bar_avatar"];
               barInfo.bar_totalPost = dic[@"bar_totalPost"];
               barInfo.bar_totalFollow = dic[@"bar_totalFollow"];
               [self.infoArray addObject:barInfo];
           }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"infoFetchOver" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
