//
//  replyInfo.m
//  XMLL2
//
//  Created by zzddn on 2017/2/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "replyInfo.h"
#import "replyVC.h"
@implementation replyInfo

- (void)fetch_reply_with_bar_name:(NSString *)bar_name and_post_id:(NSInteger)post_id andVC:(UIViewController *)replyVC2 and:(UITableView *)TV{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *postID = [NSString stringWithFormat:@"%ld",(long)post_id];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"bar_name":bar_name,
                          @"theme_post_id":postID
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/reply_post.php?action=fetch" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.replyArr = [NSMutableArray arrayWithCapacity:10];
        for (NSDictionary *dic in responseObject) {
            replyInfo *reply = [[replyInfo alloc]init];
            [reply setValuesForKeysWithDictionary:dic];
            [self.replyArr addObject:reply];
        }
        //移除动画，添加视图
        [replyVC2.view.layer removeAllAnimations];
        [replyVC2.view addSubview:TV];
        [TV reloadData];
        [(replyVC *)replyVC2 setupView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)postAReplyWithContent:(NSString *)content andBar_name:(NSString *)bar_name andUser_name:(NSString *)user_name andTheme_post_id:(NSInteger)post_id andvc:(UIViewController *)vc andPictures:(NSArray *)picArr{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *postID = [NSString stringWithFormat:@"%ld",(long)post_id];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    NSDictionary *dic = @{
                          @"content":content,
                          @"bar_name":bar_name,
                          @"user_name":user_name,
                          @"theme_post_id":postID
                          };
    [manager POST:@"http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/reply_post.php?action=reply" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            int i = 1;
        if (picArr != nil){
            for (UIImage *image in picArr) {
                NSData *data = UIImageJPEGRepresentation(image, 1);
                NSString *str = [NSString stringWithFormat:@"picture%d",i];
                NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg",user_name,i];
                [formData appendPartWithFileData:data name:str fileName:fileName mimeType:@"image/jpeg"];
                i++;
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"replySendOver" object:nil];
        
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
