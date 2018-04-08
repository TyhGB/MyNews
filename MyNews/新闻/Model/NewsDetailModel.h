//
//  NewsDetailModel.h
//  MyNews
//
//  Created by TyhOS on 2018/4/1.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject
/*标题*/
@property (nonatomic,strong) NSString *title;
/*正文*/
@property (nonatomic,strong) NSString *body;
/*时间*/
@property (nonatomic,strong) NSString *ptime;
/*图片数组*/
@property (nonatomic,strong) NSArray *img;
@end
