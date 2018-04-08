//
//  kindOfPhotosView.h
//  MyNews
//
//  Created by TyhOS on 2018/4/2.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kindOfPhotosView : UIView
@property (nonatomic,strong) NSArray *kindOfPhotosArray;

-(void)show;//显示下拉图片种类
-(void)remove;
@end
