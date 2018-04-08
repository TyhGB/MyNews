//
//  PhotoLayout.m
//  MyNews
//
//  Created by TyhOS on 2018/1/3.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "PhotoLayout.h"

@interface PhotoLayout ()
@property (nonatomic,strong) NSMutableArray *attributesArray; //每个item的attribute
@property (nonatomic,strong) NSMutableArray *colHeightArray; //每列总高度

-(CGFloat) colCount; //列数
-(CGFloat) colMargin; //列边距
-(CGFloat) rowMargin; //行边距
-(UIEdgeInsets) edgeInsets; //四周边距
@end
static const CGFloat DefaultColCount = 2;
static const CGFloat DefaultColMargin = 10;
static const CGFloat DefaultRowMargin = 10;
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};
@implementation PhotoLayout
-(void)prepareLayout
{
    [super prepareLayout];
    //数据刷新了
    if (self.photosArray.count==20) {
        [self.attributesArray removeAllObjects];
        [self.colHeightArray removeAllObjects];
    }
    //第一次布局 列高度为top边距
    if (!self.colHeightArray.count) {
        for (int i=0; i<self.colCount; i++) {
           [self.colHeightArray addObject:@(self.edgeInsets.top)];
        }
    }
    for (NSUInteger i=self.attributesArray.count; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        [self.attributesArray addObject:[self layoutAttributesForItemAtIndexPath:index]];
    }
    
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算w
    CGFloat w = (ScreenWidth-self.edgeInsets.left-self.edgeInsets.right-(self.colCount-1)*self.colMargin)/self.colCount;
    //计算h 外部传进来的图片的高度按比例缩放
    Photo *photo = self.photosArray[indexPath.item];
    CGFloat h = [photo.small_height doubleValue] * (w/[photo.small_width doubleValue]);
    //计算x
    NSUInteger destcol = 0;//拼接的目标列
    CGFloat minColHeight = [self.colHeightArray[0] doubleValue];
    for (int i=1; i<self.colCount; i++) {
        if (minColHeight>[self.colHeightArray[i] doubleValue]) {
            minColHeight = [self.colHeightArray[i] doubleValue];
            destcol = i;
        }
    }
    CGFloat x = self.edgeInsets.left + destcol*(w+self.colMargin);
    //计算y
    CGFloat y = minColHeight;
    attris.frame = CGRectMake(x, y, w, h);
    //拼接的列加上拼接item的高度
    self.colHeightArray[destcol] = @(CGRectGetMaxY(attris.frame));
    return attris;
}
-(CGSize)collectionViewContentSize
{
    CGFloat maxHeight = [self.colHeightArray[0] doubleValue];
    for (int i=0; i<self.colHeightArray.count; i++) {
        if (maxHeight<[self.colHeightArray[i] doubleValue]) {
            maxHeight = [self.colHeightArray[i] doubleValue];
        }
    }
    return  CGSizeMake(0, maxHeight+self.edgeInsets.bottom);
}


#pragma mark - 懒加载
-(NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}
-(NSMutableArray *)colHeightArray
{
    if (!_colHeightArray) {
        _colHeightArray = [[NSMutableArray alloc] init];
    }
    return _colHeightArray;
}
-(CGFloat)colCount
{
    return DefaultColCount;
}
-(CGFloat)colMargin
{
    return DefaultColMargin;
}
-(CGFloat)rowMargin
{
    return DefaultRowMargin;
}
-(UIEdgeInsets)edgeInsets
{
    return DefaultEdgeInsets;
}
@end
