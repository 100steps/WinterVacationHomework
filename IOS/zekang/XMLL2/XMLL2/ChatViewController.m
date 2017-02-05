//
//  ChatViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "ChatViewController.h"
#import "XMPPStreamManager.h"
#import "ChatToFriendViewController.h"
#import "AddFriendTableViewController.h"
@interface ChatViewController ()

@end

@implementation ChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [XMPPStreamManager sharedManager].indexDic.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ){
        return 1;
    }else{
        NSString *str = [[XMPPStreamManager sharedManager].indexDic allKeys][section - 1];
        NSArray *arr = [[XMPPStreamManager sharedManager].indexDic[str] copy];
        //返回首字母对应的用户名个数
        return arr.count;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        NSString *str = @"功能";
        return str;
    }else{
        //返回对应的标题
        return [[XMPPStreamManager sharedManager].indexDic allKeys][section - 1];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        //添加好友的cell
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add"];
        cell.imageView.image = [UIImage imageNamed:@"新的朋友"];
        cell.imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
        cell.textLabel.text = @"新的朋友";
        return cell;
    }else{
        static NSString *identify = @"list";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        //根据首字母，放入对应的用户名
     NSString *str = [[XMPPStreamManager sharedManager].indexDic allKeys][indexPath.section - 1];
     NSArray *arr = [[XMPPStreamManager sharedManager].indexDic[str] copy];
     cell.textLabel.text = arr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"占位图"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        AddFriendTableViewController *addVC = [[AddFriendTableViewController alloc]init];
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
    ChatToFriendViewController *chatVC = [[ChatToFriendViewController alloc]init];
    NSString *str = [[XMPPStreamManager sharedManager].indexDic allKeys][indexPath.section - 1];
    NSArray *arr = [[XMPPStreamManager sharedManager].indexDic[str] copy];
    //保存聊天对象。
    chatVC.title =arr[indexPath.row];
    [XMPPStreamManager sharedManager].chatJID = arr[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    //一个紧急的补救chat好友页面出现不全的方法
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section== 0) {
        
        return 5.0f;
        
    }else{
        return 20.0;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
