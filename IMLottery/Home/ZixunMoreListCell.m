//
//  ZixunMoreListCell.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "ZixunMoreListCell.h"

@implementation ZixunMoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ZixunListMoreModel *)model
{
    [self.photoIconView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    self.titleLab.text = model.title;
    self.summaryLab.text = model.summary;
    self.dateLab.text = model.date;
}
@end
