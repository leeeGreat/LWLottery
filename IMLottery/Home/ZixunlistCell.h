//
//  ZixunlistCell.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZixunListModel.h"
@interface ZixunlistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *summaryLab;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLab;
@property (nonatomic,strong) ZixunListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *photoIconView;

@end
