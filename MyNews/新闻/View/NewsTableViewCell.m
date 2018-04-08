//
//  NewsTableViewCell.m
//  MyNews
//
//  Created by TyhOS on 2017/12/25.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@end
@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.replyLabel.layer.borderWidth = 2;
    self.replyLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.replyLabel.layer.cornerRadius =5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.imgsrc];
    [self.image sd_setImageWithURL:url];
    self.titleLabel.text = model.title;
    self.sourceLabel.text = model.source;
    NSUInteger replyCount = model.replyCount;
    NSString *replyStr = replyCount>9999 ? [NSString stringWithFormat:@"%0.1f万跟帖",replyCount*1.0/10000]:[NSString stringWithFormat:@"%ld跟帖",replyCount];
    self.replyLabel.text = replyStr;
}
@end
