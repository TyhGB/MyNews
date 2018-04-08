//
//  TabbarViewController.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
    UITabBarItem *newsItem = self.tabBar.items[0];
    [newsItem setImage:[[UIImage imageNamed:@"新闻灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [newsItem setSelectedImage:[[UIImage imageNamed:@"新闻红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [newsItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    UITabBarItem *pictureItem = self.tabBar.items[1];
    [pictureItem setImage:[[UIImage imageNamed:@"图片灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [pictureItem setSelectedImage:[[UIImage imageNamed:@"图片红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [pictureItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    UITabBarItem *videoItem = self.tabBar.items[2];
    [videoItem setImage:[[UIImage imageNamed:@"视频灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [videoItem setSelectedImage:[[UIImage imageNamed:@"视频红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [videoItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    UITabBarItem *meItem = self.tabBar.items[3];
    [meItem setImage:[[UIImage imageNamed:@"我的灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [meItem setSelectedImage:[[UIImage imageNamed:@"我的红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [meItem setTitleTextAttributes:attributes forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
