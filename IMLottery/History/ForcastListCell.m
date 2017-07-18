//
//  ForcastListCell.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/17.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "ForcastListCell.h"

@implementation ForcastListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ForcastModel *)model
{
    self.userNameLab.text = model.username;
    self.calcLab.text =model.calc;
    self.hitnumLab.text = model.hitnum;
    self.awardLab.text = model.award;
    self.nextplayNameLab.text = model.nextplayname;
}
@end
