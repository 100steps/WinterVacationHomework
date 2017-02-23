//
//  BarViewController.m
//  XMLL2
//
//  Created by zzddn on 2017/1/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "BarViewController.h"
#import "BarInfo.h"
#import "barCell.h"
#import "themeVC.h"
#import <UIImageView+WebCache.h>
@interface BarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *barTableView;
@property (nonatomic,strong)BarInfo *barInfo;
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@end

@implementation BarViewController
 NSInteger barCount = 0;
- (BarInfo *)barInfo{
    if (_barInfo == nil){
        _barInfo = [BarInfo new];
    }
    return _barInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.barTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) style:UITableViewStyleGrouped];
    self.barTableView.delegate = self;
    self.barTableView.dataSource = self;
    //开始加载动画
    [self startAnimation];
    //调用获取贴吧信息方法
    [self.barInfo fetchBarInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchOver) name:@"infoFetchOver" object:nil];
    
    //添加下拉刷新动画
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在努力加载..."];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.barTableView addSubview:self.refreshControl];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl{
    [self.barInfo fetchBarInfo];
}
- (void)startAnimation{
    
    //重用层
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.position = self.view.center;
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    //点动画层
    CALayer *dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.position = CGPointMake(replicatorLayer.frame.size.width /3 /2 , replicatorLayer.frame.size.height/2 );
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = 7.5;
    dotLayer.transform = CATransform3DMakeScale(0, 0, 0);
    [replicatorLayer addSublayer:dotLayer];
    
    //设置重用点实例的个数，和转换方式
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorLayer.frame.size.width/3, 0, 0);
    
    //添加缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:animation forKey:nil];
    
    //设置点实例间动画的延迟
    replicatorLayer.instanceDelay = 1.0/3;

}
- (void)fetchOver{
    barCount = self.barInfo.infoArray.count;
    //结束加载动画
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.view.layer removeAllAnimations];
        [self.view addSubview:_barTableView];
    });
    if (self.refreshControl.isRefreshing){
        [self.refreshControl endRefreshing];
        [self.barTableView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return barCount;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    barCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barCell"];
    if (cell == nil){
        cell = [[barCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"barCell"];
    }
    BarInfo *bar = self.barInfo.infoArray[indexPath.row];
    cell.barInfo = bar;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BarInfo *bar = self.barInfo.infoArray[indexPath.row];
    themeVC *theme = [[themeVC alloc]init];
    theme.navigationItem.title = bar.bar_name.copy;
    [self.navigationController pushViewController:theme animated:YES];
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
