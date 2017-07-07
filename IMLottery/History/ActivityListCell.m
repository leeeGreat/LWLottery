//
//  ActivityListCell.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/7.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "ActivityListCell.h"

@implementation ActivityListCell
- (void)setModel:(ActivityModel *)model
{
    [self.mapIcon sd_setImageWithURL:[NSURL URLWithString:model.mapAddress]];
    self.contentLab.text = model.content;
    NSString *startStr = [model.stTime substringToIndex:10];
    NSString *endStr = [model.enTime substringToIndex:10];
    self.timeLab.text = [NSString stringWithFormat:@"活动时间：%@-%@",startStr,endStr];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
