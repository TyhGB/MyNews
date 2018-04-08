//
//  NSString+YHExtension.h
//  MyNews
//
//  Created by TyhOS on 2018/1/4.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YHExtension)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
