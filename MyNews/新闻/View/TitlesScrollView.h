//
//  TitlesScrollView.h
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitlesScrollViewDelegate

@optional
-(void)titlesScrollView:(UIScrollView *)titlesScrollView didSelectedButton:(UIButton *)selectedButton;

@end


@interface TitlesScrollView : UIScrollView
//NSString的数组，存放标题名称
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,weak) id<TitlesScrollViewDelegate> titleSVDelegate;

//根据底部内容滑动的偏移量，得到对应的button的tag传入
-(void)letButtonSelected:(NSUInteger)tag;

@end
