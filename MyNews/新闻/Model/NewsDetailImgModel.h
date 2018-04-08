//
//  NewsDetailImgModel.h
//  MyNews
//
//  Created by TyhOS on 2018/4/1.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailImgModel : NSObject
/* 图片顺序 */
@property(nonatomic,strong) NSString *ref;
/* 图片地址 */
@property (nonatomic,strong) NSString *src;
/* 图片大小 */
@property (nonatomic,strong) NSString *pixel;

@end
