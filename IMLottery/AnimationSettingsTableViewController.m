//
//  AnimationSettingsTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "AnimationSettingsTableViewController.h"
#import "IMSwitchCellModel.h"
#import "IMCellGroupModel.h"

@interface AnimationSettingsTableViewController ()

@end

@implementation AnimationSettingsTableViewController

- (void)settingCellsData{
    
    IMSwitchCellModel *model00 = [IMSwitchCellModel IMCellModelWithImage:[UIImage imageNamed:@"MorePush"] title:@"双色球"];
    
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00];
    group01.header = @"当你有新中奖订单，启动程序时通过动画提醒您。为避免过于频繁，高频彩不会提醒。";
    [self.cells addObject:group01];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}
@end
