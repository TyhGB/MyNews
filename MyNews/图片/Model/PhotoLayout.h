//
//  PhotoLayout.h
//  MyNews
//
//  Created by TyhOS on 2018/1/3.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
@interface PhotoLayout : UICollectionViewLayout

@property (nonatomic,strong) NSArray <Photo *> *photosArray;

@end
