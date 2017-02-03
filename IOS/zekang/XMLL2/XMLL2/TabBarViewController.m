//
//  TabBarViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "TabBarViewController.h"
#import "MeViewController.h"
#import "ProfileViewController.h"
#import "ChatViewController.h"
#import "BarViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithViewCotrollers];
}
-(void)initWithViewCotrollers{
    NSMutableArray *mutableArr = [[NSMutableArray alloc]initWithCapacity:4];
    ProfileViewController *profileVC = [[ProfileViewController alloc]init];
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    BarViewController *barVC = [[BarViewController alloc]init];
    MeViewController *meVC  = [[MeViewController alloc]init];
    
    profileVC.title = @"首页";
    chatVC.title = @"消息";
    barVC.title = @"贴吧";
    meVC.title = @"我";
    
    profileVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    profileVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    chatVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    chatVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    barVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    barVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    meVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    
    NSArray *arr = [NSArray arrayWithObjects:profileVC,chatVC,barVC,meVC,nil];
    for (int i = 0; i<4; i++){
        UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:arr[i]];
        [mutableArr addObject:naviVC];
    self.viewControllers = mutableArr;
   }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
