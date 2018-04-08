//
//  TitlesScrollView.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "TitlesScrollView.h"

@interface TitlesScrollView ()
@property (nonatomic,strong) UIView *downLine;
@property (nonatomic,strong) UIButton *selectedBtn;
@end
@implementation TitlesScrollView

#define ButtonWidth  [UIScreen mainScreen].bounds.size.width/5;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    NSUInteger count = [titles count];
    CGFloat btnWid = ButtonWidth;
    self.contentSize = CGSizeMake(btnWid*count, self.height);
    for (int i=0; i<count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*btnWid, 0, btnWid, self.height-2);
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i+100;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i==0) {
            //按钮下划指示线
            self.downLine = [[UIView alloc]initWithFrame:CGRectMake(0, button.maxY, btnWid, 2)];
            self.downLine.backgroundColor = [UIColor redColor];
            self.selectedBtn = button;
            [self addSubview:self.downLine];
        }
    }
}
-(void)click:(UIButton *)btn
{
    self.selectedBtn = btn;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.downLine.frame;
        rect.origin.x = (btn.tag-100)*ButtonWidth;
        self.downLine.frame = rect;
    }];
    [self setUpButtonCenter];
}
-(void)setUpButtonCenter
{
    CGFloat offset = self.selectedBtn.center.x-ScreenWidth*0.5;
    if (offset<0) {
        offset=0;
    }
    //有展开标题按钮就多加50
    CGFloat maxOffset = self.contentSize.width-ScreenWidth+50;
    if (offset>maxOffset) {
        offset = maxOffset;
    }
    //设置scrollview偏移量，让按钮居中
    [self setContentOffset:CGPointMake(offset, 0) animated:YES];
#warning 这里代理的contentoffset有延迟 需要等animated结束才正确，多线程group？
    [self.titleSVDelegate titlesScrollView:self didSelectedButton:self.selectedBtn];
}
-(void)letButtonSelected:(NSUInteger)tag
{
    UIButton *button = (UIButton *)[self viewWithTag:tag];
    [self click:button];
}
@end
