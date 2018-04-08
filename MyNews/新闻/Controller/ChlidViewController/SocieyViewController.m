//
//  SocieyViewController.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SocieyViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "HeaderViewModel.h"
#import "NewsDetailModel.h"
#import "NewsDetailImgModel.h"

@interface SocieyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *adsArray;//轮播图数组
@property (nonatomic,strong) NSMutableArray *listArray; //列表数据，包含NewsModel类型的数组
@property (nonatomic,assign) NSUInteger pageNumber;
@property (nonatomic,strong) NSString *docid;//详情新闻拼接符号
@property (nonatomic,strong) NewsDetailModel *newsDetailModel;
@end

@implementation SocieyViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        CGRect rect = self.view.frame;
        rect.size.height -=119; //减去状态栏和顶部、底部导航栏高度
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNewData];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        
    }
    return _tableView;
}
-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
-(NSMutableArray *)adsArray
{
    if (!_adsArray) {
        _adsArray = [NSMutableArray array];
    }
    return _adsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"社会";
    self.pageNumber = 0;
    [self.view addSubview:self.tableView];

    [self loadData];
}
-(void)initTableHeaderView
{
    NSMutableArray *imgUrlArray = [NSMutableArray array];
    NSMutableArray *imgTitleArray = [NSMutableArray array];
    for (int i=0; i<self.adsArray.count; i++) {
        HeaderViewModel *model = self.adsArray[i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imgsrc]];
        NSString *title = model.title;
        [imgUrlArray addObject:url];
        [imgTitleArray addObject:title];
    }
    //轮播图
    SDCycleScrollView *headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 250) imageURLStringsGroup:imgUrlArray];
    headerView.titlesGroup = imgTitleArray;
    headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.tableView.tableHeaderView = headerView;
    
    
}
//初始加载的数据
-(void)loadData
{
    NSString *url = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html";
    [YHNetworkTool requestWithUrlString:url parameters:nil method:@"GET" success:^(id resposeObject) {
        [self.tableView.mj_header endRefreshing];
        [self.listArray removeAllObjects];
        [self.adsArray removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resposeObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [dic valueForKey:@"T1348647853363"];
        for (int i=0; i<array.count; i++) {
            if (i==0) {
                NSDictionary *dic0 = array[0];
                NSArray *array1 = [dic0 valueForKey:@"ads"];
                for (int j=0; j<array1.count; j++) {
                    NSDictionary *dic2 = array1[j];
                    HeaderViewModel *adsModel = [[HeaderViewModel alloc] init];
                    adsModel.title = [dic2 valueForKey:@"title"];
                    adsModel.imgsrc = [dic2 valueForKey:@"imgsrc"];
                    [self.adsArray addObject:adsModel];
                }
                [self initTableHeaderView];
            }else{
                NSDictionary *dic2= array[i];
                NewsModel *model = [[NewsModel alloc] init];
                model.title = [dic2 valueForKey:@"title"];
                model.imgsrc = [dic2 valueForKey:@"imgsrc"];
                model.source = [dic2 valueForKey:@"source"];
                model.replyCount = [[dic2 valueForKey:@"replyCount"] integerValue];
                model.url = [dic2 valueForKey:@"url"];
                model.url_3w = [dic2 valueForKey:@"url_3w"];
                model.docid = [dic2 valueForKey:@"docid"];
                [self.listArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showWithStatus:@"请求失败"];
    }];
}
//下拉加载的数据(轮播图不跟新)
-(void)loadNewData
{
    //页码+1
    self.pageNumber++;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%lu-20.html",self.pageNumber*20];
    [YHNetworkTool requestWithUrlString:url parameters:nil method:@"GET" success:^(id resposeObject) {
        [self.tableView.mj_header endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resposeObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [dic valueForKey:@"T1348647853363"];
        for (int i=0; i<array.count; i++) {
            if (i==0) {
                continue;
            }else{
                NSDictionary *dic2= array[i];
                NewsModel *model = [[NewsModel alloc] init];
                model.title = [dic2 valueForKey:@"title"];
                model.imgsrc = [dic2 valueForKey:@"imgsrc"];
                model.source = [dic2 valueForKey:@"source"];
                model.replyCount = [[dic2 valueForKey:@"replyCount"] integerValue];
                model.url = [dic2 valueForKey:@"url"];
                model.url_3w = [dic2 valueForKey:@"url_3w"];
                model.docid = [dic2 valueForKey:@"docid"];
                [self.listArray insertObject:model atIndex:0];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showWithStatus:@"请求失败"];
    }];
}
//上拉加载的数据
-(void)loadMoreData
{
    //页码+1
    self.pageNumber++;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%lu-20.html",self.pageNumber*20];
    [YHNetworkTool requestWithUrlString:url parameters:nil method:@"GET" success:^(id resposeObject) {
        [self.tableView.mj_footer endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resposeObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [dic valueForKey:@"T1348647853363"];
        for (int i=0; i<array.count; i++) {
            if (i==0) {
                continue;
            }else{
                NSDictionary *dic2= array[i];
                NewsModel *model = [[NewsModel alloc] init];
                model.title = [dic2 valueForKey:@"title"];
                model.imgsrc = [dic2 valueForKey:@"imgsrc"];
                model.source = [dic2 valueForKey:@"source"];
                model.replyCount = [[dic2 valueForKey:@"replyCount"] integerValue];
                model.url = [dic2 valueForKey:@"url"];
                model.url_3w = [dic2 valueForKey:@"url_3w"];
                model.docid = [dic2 valueForKey:@"docid"];
                [self.listArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showWithStatus:@"请求失败"];
    }];
}
//
-(void)loadDetailData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.docid];
    [YHNetworkTool requestWithUrlString:url parameters:nil method:@"GET" success:^(id resposeObject) {
        [self.tableView.mj_header endRefreshing];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resposeObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *detailDic = [dic valueForKey:self.docid];
        NewsDetailModel *detailModel = [[NewsDetailModel alloc] init];
        detailModel.title = [detailDic valueForKey:@"title"];
        detailModel.ptime = [detailDic valueForKey:@"ptime"];
        detailModel.body = [detailDic valueForKey:@"body"];
        detailModel.img = [detailDic valueForKey:@"img"];
        self.newsDetailModel = detailModel;
        [self showInWebview];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"请求详情失败");
    }];
}
-(void)showInWebview
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"Detail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    TYH_WebViewController *VC = [[TYH_WebViewController alloc] init];
    VC.htmlString = html;
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.newsDetailModel.title];
    [body appendFormat:@"<div class=\"ptime\">%@</div>",self.newsDetailModel.ptime];
    [body appendString:self.newsDetailModel.body];
    for (NSDictionary *dic in self.newsDetailModel.img) {
        NewsDetailImgModel *imgModel = [[NewsDetailImgModel alloc] init];
        imgModel.ref = [dic valueForKey:@"ref"];
        imgModel.src = [dic valueForKey:@"src"];
        imgModel.pixel = [dic valueForKey:@"pixel"];
        
        NSMutableString *imgString = [NSMutableString string];
        [imgString appendFormat:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [imgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgString appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,imgModel.src];
        // 结束标记
        [imgString appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:imgModel.ref withString:imgString options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    
    return body;
}

#pragma mark - tableview delegate and datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:nil options:nil] firstObject];
        NewsModel *model = self.listArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsModel *model = self.listArray[indexPath.row];
    self.docid = model.docid;
    [self loadDetailData];

}
@end
