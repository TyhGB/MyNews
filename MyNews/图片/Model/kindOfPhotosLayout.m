//
//  kindOfPhotosLayout.m
//  MyNews
//
//  Created by TyhOS on 2018/4/2.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "kindOfPhotosLayout.h"

@interface kindOfPhotosLayout()

@property (nonatomic,strong) NSMutableArray * attributeArray;

@end
@implementation kindOfPhotosLayout
-(void)prepareLayout
{
    self.attributeArray = [[NSMutableArray alloc] init];
    [super prepareLayout];
    for (int i=0; i<self.kindOfPhotos.count; i++) {
        //设置每个item的属性
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        //四列
        NSInteger col = i%4;
        NSInteger row = i/4;
        attris.frame = CGRectMake(100*col, row*100, 100, 100);
        [self.attributeArray addObject:attris];
        
    }
                           
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeArray;
}
@end
