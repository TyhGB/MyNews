//
//  PhotoCollectionView.m
//  MyNews
//
//  Created by TyhOS on 2018/1/4.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "PhotoCollectionView.h"

@implementation PhotoCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

-(void)setupCollectionView
{
    self.backgroundColor = [UIColor whiteColor];
}
@end
