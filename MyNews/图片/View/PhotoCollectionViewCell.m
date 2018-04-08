//
//  PhotoCollectionViewCell.m
//  MyNews
//
//  Created by TyhOS on 2018/1/4.
//  Copyright © 2018年 TyhOS. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
@interface PhotoCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation PhotoCollectionViewCell
-(void)setPhoto:(Photo *)photo
{
    _photo = photo;
    NSURL *url = [NSURL URLWithString:photo.small_url];
    [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]]; //后面的占位图暂时没有
    self.titleLabel.text = photo.title;
}
@end
