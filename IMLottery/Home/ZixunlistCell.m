//
//  ZixunlistCell.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "ZixunlistCell.h"

@implementation ZixunlistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.typeNameLab.layer.cornerRadius = 5;
    self.typeNameLab.layer.borderColor =[UIColor orangeColor].CGColor;
    self.typeNameLab.layer.borderWidth = 1;
    self.typeNameLab.layer.masksToBounds  = YES;
    self.typeNameLab.clipsToBounds = YES;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}
- (void)setModel:(ZixunListModel *)model
{
    self.titleLab.text = model.title;
    self.summaryLab.text = model.summary;
    self.typeNameLab.text = @"综合分析";
    if (model.typeName.length>0) {
        self.typeNameLab.text = model.typeName;
    }
    
    [self.photoIconView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
