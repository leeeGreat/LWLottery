//
//  IMTableViewCell.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMCellModel;

@interface IMTableViewCell : UITableViewCell

@property (nonatomic, strong) IMCellModel *model;

@end
