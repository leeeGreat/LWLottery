//
//  ForcastListCell.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/17.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForcastModel.h"
@interface ForcastListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *hitnumLab;

@property (weak, nonatomic) IBOutlet UILabel *calcLab;
@property (weak, nonatomic) IBOutlet UILabel *nextplayNameLab;
@property (weak, nonatomic) IBOutlet UILabel *awardLab;



@property (nonatomic,strong) ForcastModel *model;
@end
