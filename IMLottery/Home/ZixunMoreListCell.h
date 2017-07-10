//
//  ZixunMoreListCell.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "ZixunListMoreModel.h"
#import <UIKit/UIKit.h>

@interface ZixunMoreListCell : UITableViewCell
@property (nonatomic,strong) ZixunListMoreModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *photoIconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *summaryLab;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end
