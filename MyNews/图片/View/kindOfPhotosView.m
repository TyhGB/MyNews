//
//  kindOfPhotosView.m
//  MyNews
//
//  Created by TyhOS on 2018/4/2.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "kindOfPhotosView.h"

@interface kindOfPhotosView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *kindOfPhotos;
@end
@implementation kindOfPhotosView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, ScreenWidth , ScreenHeight - 64);
        self.backgroundColor = [UIColor clearColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(50, 75);
        layout.minimumInteritemSpacing = (ScreenWidth - 200)/5.f;
        layout.minimumLineSpacing = 20.f;
        layout.sectionInset = UIEdgeInsetsMake(20, (ScreenWidth - 250)/5.f, 0, (ScreenWidth - 250)/5.f);
        
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 0) collectionViewLayout:layout];
        collection.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8];
        collection.dataSource = self;
        collection.delegate = self;
        [self addSubview:collection];
        self.kindOfPhotos = collection;
        
        [self.kindOfPhotos registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"kind"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.kindOfPhotosArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kind" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}
-(void)show
{
    [[[UIApplication sharedApplication] delegate].window addSubview:self.kindOfPhotos];
    [UIView animateWithDuration:0.5 animations:^{
        self.kindOfPhotos.height = 400;
    }];
}
-(void)remove
{
    [UIView animateWithDuration:0.5 animations:^{
        self.kindOfPhotos.height=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
