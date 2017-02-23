//
//  ThemeInfo.m
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "ThemeInfo.h"
#import <AFHTTPSessionManager.h>
@implementation ThemeInfo

- (void)fetch_theme_post:(NSString *)bar_name{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"bar_name":bar_name
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/theme_post.php?action=fetch" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.themeArr = [NSMutableArray arrayWithCapacity:9];
        for (NSDictionary *dic in responseObject) {
            ThemeInfo *themeInfo = [ThemeInfo new];
            themeInfo.bar_name = dic[@"bar_name"];
            themeInfo.title = dic[@"title"];
            themeInfo.content = dic[@"content"];
            themeInfo.pictures = dic[@"pictures"];
            themeInfo.thumbnails = dic[@"thumbnails"];
            themeInfo.user_name = dic[@"user_name"];
            themeInfo.post_id =   ((NSString *)dic[@"post_id"]).integerValue;
            themeInfo.post_time = dic[@"post_time"];
            themeInfo.post_number = ((NSString *)dic[@"post_number"]).integerValue;
            [self.themeArr addObject:themeInfo];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"themeFetchOver" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了，失败原因:%@",error);
    }];
}
- (void)post_theme_post:(NSString *)bar_name user_name:(NSString *)user_name pictureArr:(NSArray *)pictures title:(NSString *)title content:(NSString *)content{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"title":title,
                          @"content":content,
                          @"bar_name":bar_name,
                          @"user_name":user_name
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/theme_post.php?action=post" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 1;
        if (pictures != nil){
        for (UIImage *image in pictures) {
          NSData *data = UIImageJPEGRepresentation(image, 1);
            NSString *str = [NSString stringWithFormat:@"picture%d",i];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg",user_name,i];
            [formData appendPartWithFileData:data name:str fileName:fileName mimeType:@"image/jpeg"];
            i++;
           }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)getPicturesCount{
    if (self.pictures == nil || [self.pictures isEqual:[NSNull null]] || [self.pictures isEqual:@""] ){
        return 0;
    }
    NSRange range = [self.pictures rangeOfString:@","];
    if (range.location != NSNotFound){
        NSArray *array = [self.pictures componentsSeparatedByString:@","];
        if (array.count <= 3){return 1;}
        if (array.count <= 6){return 2;}
        if (array.count <= 9){return 3;}
    }
    return 1;
}
@end
