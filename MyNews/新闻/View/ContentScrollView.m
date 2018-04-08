//
//  ContentScrollView.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "ContentScrollView.h"

@implementation ContentScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
-(void)setViewsArray:(NSArray *)viewsArray
{
    _viewsArray = viewsArray;
    NSUInteger count = [_viewsArray count];
    self.contentSize = CGSizeMake(ScreenWidth*count, self.height);
    for (int i=0; i<count; i++) {
        float x = ScreenWidth*i;
        UIView *view = _viewsArray[i];
        view.frame = CGRectMake(x, 0, ScreenWidth, self.height);
        [self addSubview:view];
    }
}
@end
