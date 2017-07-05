//
//  TimerSettingsTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "TimerSettingsTableViewController.h"
#import "IMSwitchCellModel.h"
#import "IMCellGroupModel.h"

@interface TimerSettingsTableViewController ()

@end

@implementation TimerSettingsTableViewController

- (void)settingCellsData{
    
    IMSwitchCellModel *model00 = [IMSwitchCellModel IMCellModelWithtitle:@"双色球"];
    
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00];
    group01.header = @"您可以通过设置，提醒自己在开奖日不要忘记购买彩票。";
    [self.cells addObject:group01];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}
@end
