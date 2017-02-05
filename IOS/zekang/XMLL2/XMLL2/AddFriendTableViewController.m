//
//  AddFriendTableViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/26.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "AddFriendTableViewController.h"
#import "XMPPStreamManager.h"
#import "searchFriendVC.h"
@interface AddFriendTableViewController ()
@property (nonatomic,copy)NSString *fromStr;
@end

@implementation AddFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //右端添加好友item
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDidClick)];
    self.navigationItem.rightBarButtonItem = item;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//在这个方法中，实现主动添加好友页面的跳转
-(void)addDidClick{
    searchFriendVC *search = [[searchFriendVC alloc]init];
    search.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:search animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [XMPPStreamManager sharedManager].addArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addCell"];
    }
    [self customCell:cell andIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"占位图"];
    NSString *str = [NSString stringWithFormat:@"%@想要加你为好友",[XMPPStreamManager sharedManager].addArray[indexPath.row]];
    NSString *cutStr = [str stringByReplacingOccurrencesOfString:@"@192.168.1.102" withString:@""];
    cell.textLabel.text = cutStr;
    return cell;
}
- (void)customCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath{
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    agreeButton.frame = CGRectMake(320 - 40, 0, 40, 40);
    agreeButton.tag = indexPath.row;
    [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    agreeButton.backgroundColor = [UIColor blueColor];
    [agreeButton setTintColor:[UIColor blackColor]];
    [agreeButton addTarget:self action:@selector(agreeAddFriend:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:agreeButton];
}
- (void)agreeAddFriend:(UIButton *)sender{
    //同意添加好友
    NSString *str = [NSString stringWithFormat:@"%@",[XMPPStreamManager sharedManager].addArray[sender.tag]];
    XMPPJID *jid = [XMPPJID jidWithString:str];
    [[XMPPStreamManager sharedManager].roster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
