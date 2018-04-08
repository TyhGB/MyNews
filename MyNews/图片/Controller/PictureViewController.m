//
//  PictureViewController.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "PictureViewController.h"
#import "PhotoLayout.h"
#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"
#import "NSString+YHExtension.h"
#import "kindOfPhotosView.h"
@interface PictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) PhotoCollectionView *photoCollectionView;
@property (nonatomic,strong) NSMutableArray *photosArray;
@property (nonatomic,assign) NSUInteger pageNumber;
@property (nonatomic,strong) NSArray *kindOfPhotosArray;
@property (nonatomic,strong) kindOfPhotosView *kindOfPhotosView;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    //右上角button设置
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    [button setTitle:@"摄影" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //button标题图片位置设置
    CGRect btnRect = [button.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(60, 44)];//字体默认18px
    CGFloat titleW = btnRect.size.width;
    CGFloat imgW = button.imageView.frame.size.width;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, titleW, 0, -titleW);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW, 0, imgW);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self setupCollectionView];
    [self getPhotosData];
    
    self.kindOfPhotosArray = @[@"摄影",@"美女",@"明星",@"汽车",@"宠物",@"动漫",@"设计",@"家具",@"婚嫁",@"美食"];

}
//右上角button点击
-(void)rightButtonClick:(UIButton*)btn
{
    if (btn.selected) {
        btn.imageView.transform = CGAffineTransformRotate(btn.imageView.transform, M_PI);
        [self.kindOfPhotosView show];
        
    }else{
        btn.imageView.transform = CGAffineTransformIdentity;
        [self.kindOfPhotosView remove];
    }
    
    btn.selected = !btn.selected;
}
-(void)setupCollectionView
{
    PhotoLayout *layout = [[PhotoLayout alloc] init];
    layout.photosArray = self.photosArray;
    self.photoCollectionView = [[PhotoCollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.photoCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewPhotos)];
    self.photoCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMorePhotos)];
    [self.view addSubview:self.photoCollectionView];
}
-(void)getData:(NSUInteger)page cleanPhotos:(BOOL) YorN
{
    NSString *url = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=摄影&tag2=全部&pn=%ld&rn=20",page];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//中文转码
    [YHNetworkTool requestWithUrlString:url parameters:nil method:@"GET" success:^(id resposeObject) {
        [self.photoCollectionView.mj_header endRefreshing];
        [self.photoCollectionView.mj_footer endRefreshing];
        if (YorN) {
            [self.photosArray removeAllObjects];
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resposeObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *arr = [dic valueForKey:@"imgs"];
        for (int i=0; i<arr.count; i++) {
            NSDictionary *imgDic = arr[i];
            Photo *photo = [[Photo alloc] init];
            photo.small_url = [imgDic valueForKey:@"small_url"];
            photo.small_width = [imgDic valueForKey:@"small_width"];
            photo.small_height = [imgDic valueForKey:@"small_height"];
            photo.title = [imgDic valueForKey:@"title"];
            [self.photosArray addObject:photo];
        }
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.photoCollectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败：%@",error);
    }];
}
-(void)getPhotosData
{
    self.pageNumber = 0;
    [self getData:self.pageNumber cleanPhotos:NO];
}
-(void)getNewPhotos
{
    self.pageNumber = arc4random()%3000;
    [self getData:self.pageNumber cleanPhotos:YES];
}
-(void)getMorePhotos
{
    self.pageNumber++;
    [self getData:self.pageNumber cleanPhotos:NO];
}
#pragma mark - uicollectionView delegate and dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    Photo *photo = self.photosArray[indexPath.item];
    cell.photo = photo;
    return cell;
}
#pragma mark - 懒加载
-(NSMutableArray *)photosArray
{
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    return _photosArray;
}
-(kindOfPhotosView *)kindOfPhotosView
{
    if (!_kindOfPhotosView) {
        _kindOfPhotosView = [[kindOfPhotosView alloc] init];
        _kindOfPhotosView.kindOfPhotosArray = self.kindOfPhotosArray;
    }
    return _kindOfPhotosView;
}
@end
