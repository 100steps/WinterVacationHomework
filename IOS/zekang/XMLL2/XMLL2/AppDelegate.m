

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "FirstUseViewController.h"
#import "TabBarViewController.h"
#import "XMPPStreamManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self backToHome];
    return YES;
}
- (void)backToHome{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"SomeStatus.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //权限最高的给根视图
    TabBarViewController *tabBarVC = [[TabBarViewController alloc]init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    //判断是否是第一次使用
    if (!dic[@"used"]){
        //如果是，则展示第一次使用界面（退出后登陆也算是第一次使用)
        _window2 = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        FirstUseViewController *firstUseVC = [[FirstUseViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:firstUseVC];
        self.window2.rootViewController = navi;
        [_window2 makeKeyAndVisible];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidResignKey) name:UIWindowDidResignKeyNotification object:nil];
    }else{
        [[XMPPStreamManager sharedManager].xmppStream disconnect];
        XMPPJID *myJID =  [XMPPJID jidWithUser:dic[@"user"] domain:@"192.168.1.102" resource:nil];
        [[XMPPStreamManager sharedManager] loginToServerWithJID:myJID andPassword:dic[@"password"] andTitle:@"登录"];
    }
}
- (void)DidResignKey{
    if (self.window2 != nil){
    [self.window2.rootViewController.view removeFromSuperview];
    [((UINavigationController *)self.window2.rootViewController) removeFromParentViewController];
    self.window2.rootViewController =nil;
    [self.window2 removeFromSuperview];
    self.window2 =nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
     
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
