//
//  ActivityListCell.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/7.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "ActivityModel.h"
#import <UIKit/UIKit.h>

@interface ActivityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mapIcon;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (nonatomic,strong)ActivityModel *model;
@end
