//
//  NSString+YHExtension.m
//  MyNews
//
//  Created by TyhOS on 2018/1/4.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "NSString+YHExtension.h"

@implementation NSString (YHExtension)

-(CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
}
@end
