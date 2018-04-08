//
//  NewsViewController.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "NewsViewController.h"
#import "TitlesScrollView.h"
#import "ContentScrollView.h"

//子控制器
#import "SocieyViewController.h"
#import "NativeViewController.h"
#import "InternationalViewController.h"
#import "EntertainmentViewController.h"
#import "SportViewController.h"
#import "TechnologyViewController.h"
#import "FunViewController.h"
#import "LifeViewController.h"

@interface NewsViewController ()<TitlesScrollViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *titlesArray;
@property (nonatomic,strong) ContentScrollView *contentScrollView;
@property (nonatomic,strong) TitlesScrollView *titlesScrollView;
@property (nonatomic,strong) NSMutableArray *viewsArray;//子控制器视图数组
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新闻";
    self.titlesArray = @[@"社会",@"国内",@"国际",@"娱乐",@"体育",@"科技",@"奇闻趣事",@"生活健康"];
    //设置子控制器
    [self setupChildViewControllers];
    //顶部导航栏
    self.titlesScrollView = [[TitlesScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.width-50, 50)];
    self.titlesScrollView.titles =self.titlesArray;
    self.titlesScrollView.backgroundColor = [UIColor whiteColor];
    self.titlesScrollView.titleSVDelegate = self;
    [self.view addSubview:self.titlesScrollView];
    
    //底部内容展示
    self.contentScrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight-70-49)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.viewsArray = self.viewsArray;
    [self.view addSubview:self.contentScrollView];
    
    //标题展示按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.titlesScrollView.maxX, 20, 50, 50);
    [button setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
}
-(void)setupChildViewControllers
{
    self.viewsArray = [NSMutableArray array];
    SocieyViewController *societyVC = [[SocieyViewController alloc] init];
    [self.viewsArray addObject:societyVC.view];
    [self addChildViewController:societyVC];
    
    NativeViewController *nativeVC = [[NativeViewController alloc] init];
    [self.viewsArray addObject:nativeVC.view];
    [self addChildViewController:nativeVC];
    
    InternationalViewController *internationalVC = [[InternationalViewController alloc] init];
    [self.viewsArray addObject:internationalVC.view];
    [self addChildViewController:internationalVC];
    
    EntertainmentViewController *enterainmentVC = [[EntertainmentViewController alloc] init];
    [self.viewsArray addObject:enterainmentVC.view];
    [self addChildViewController:enterainmentVC];
    
    SportViewController *sportVC = [[SportViewController alloc] init];
    [self.viewsArray addObject:sportVC.view];
    [self addChildViewController:sportVC];
    
    TechnologyViewController *technologyVC = [[TechnologyViewController alloc] init];
    [self.viewsArray addObject:technologyVC.view];
    [self addChildViewController:technologyVC];
    
    FunViewController *funVC = [[FunViewController alloc] init];
    [self.viewsArray addObject:funVC.view];
    [self addChildViewController:funVC];
    
    LifeViewController *lifeVC = [[LifeViewController alloc] init];
    [self.viewsArray addObject:lifeVC.view];
    [self addChildViewController:lifeVC];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - TitlesScrollView titleSVDelegate
-(void)titlesScrollView:(UIScrollView *)titlesScrollView didSelectedButton:(UIButton *)selectedButton
{
    //标题导航栏中标题选中，让对应底部内容跳转
    NSUInteger index = selectedButton.tag - 100;
    CGFloat offset = index * ScreenWidth;
    [self.contentScrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
    
}
#pragma mark - ContentScrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //底部内容滑动让对应的标题选中
    NSUInteger index = self.contentScrollView.contentOffset.x/ScreenWidth;
    NSUInteger tag = index+100;
    [self.titlesScrollView letButtonSelected:tag];
}
@end
