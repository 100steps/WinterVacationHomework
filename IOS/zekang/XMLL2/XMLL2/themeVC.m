//
//  themeVC.m
//  XMLL2
//
//  Created by zzddn on 2017/2/21.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "themeVC.h"
#import "ThemeInfo.h"
#import "ThemeCell.h"
#import "postThemeVC.h"
#import "replyVC.h"
@interface themeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *themeTV;
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@end

@implementation themeVC
- (ThemeInfo *)themeInfo{
    if (_themeInfo == nil){
        _themeInfo = [[ThemeInfo alloc]init];
    }
    return _themeInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.themeTV = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.themeTV.delegate = self;
    self.themeTV.dataSource = self;
    
    //注册自定义cell
    [self.themeTV registerClass:[ThemeCell class] forCellReuseIdentifier:@"cell"];
    
    //开始发送网络请求
     [self.themeInfo fetch_theme_post:self.navigationItem.title.copy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeFetchOver) name:@"themeFetchOver" object:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStyleDone target:self action:@selector(post_a_theme_post)];
    [self startAnimation];
    
    //添加下拉刷新动画
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在努力加载..."];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.themeTV addSubview:_refreshControl];
}
- (void)beginRefresh:(UIRefreshControl *)control{
    [self.themeInfo fetch_theme_post:self.navigationItem.title.copy];
}
- (void)post_a_theme_post{
    postThemeVC * postVC = [[postThemeVC alloc]init];
    //把贴吧名字信息传过去
    postVC.bar_name = self.navigationItem.title.copy;
    [self.navigationController pushViewController:postVC animated:YES];
}
- (void)themeFetchOver{
    if ([self.refreshControl isRefreshing]){
        [self.refreshControl endRefreshing];
        [self.themeTV reloadData];
        return;
    }
    [self.view addSubview:_themeTV];
    [self.view.layer removeAllAnimations];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.themeInfo.themeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeCell *cell = [self.themeTV dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSIndexPath *currentIndexPath = [self.themeTV indexPathForRowAtPoint:cell.center];
    cell.currentRow = currentIndexPath.row;
    cell.originalRow = indexPath.row;
    cell.themeInfo = self.themeInfo.themeArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    replyVC *reply = [replyVC new];
    ThemeInfo *themeInfo = self.themeInfo.themeArr[indexPath.row];
    reply.navigationItem.title = self.navigationItem.title;
    reply.themeInfo = themeInfo;
    [self.navigationController pushViewController:reply animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeInfo *themeDeemo = self.themeInfo.themeArr[indexPath.row];
    CGSize size = [self getHeightText:themeDeemo.title andFontsize:19 andMAXheight:49];
    CGSize size2 = [self getHeightText:themeDeemo.content andFontsize:15 andMAXheight:36];
    
   NSInteger rowCount =  [themeDeemo getPicturesCount];
    if (rowCount == 0){
        return 21 + size.height + 5 + size2.height + 5 + 20;
    }
    if (rowCount == 1){return 21 + size.height + 5 + size2.height + 5 + 70 + 20;}
    if (rowCount == 2){return 21 + size.height + 5 + size2.height + 5 + 70 *2 + 20;}
    return 21 + size.height + 5 + size2.height + 5 + 70 *3 + 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGSize)getHeightText:(NSString *)text andFontsize:(CGFloat)fontsize andMAXheight:(CGFloat)max_height{
    NSDictionary *attribute = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:fontsize]
                                };
    CGSize size = [text boundingRectWithSize:CGSizeMake(250, max_height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}
@end
