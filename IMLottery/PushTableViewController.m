//
//  PushTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "PushTableViewController.h"
#import "IMTableViewCell.h"
#import "IMCellGroupModel.h"
#import "IMArrowCellModel.h"
#import "IMSwitchCellModel.h"
#import "PushSettingsTableViewController.h"
#import "AnimationSettingsTableViewController.h"
#import "ReminderSettingsTableViewController.h"
#import "TimerSettingsTableViewController.h"

@interface PushTableViewController ()

@end

@implementation PushTableViewController

- (void)settingCellsData{
    
    IMArrowCellModel *model00 = [IMArrowCellModel IMArrowCellModelWithtitle:@"推送和提醒"  destVcClass:[PushSettingsTableViewController class]];
    IMArrowCellModel *model01 = [IMArrowCellModel IMArrowCellModelWithtitle:@"中奖动画"  destVcClass:[AnimationSettingsTableViewController class]];
    IMArrowCellModel *model02 = [IMArrowCellModel IMArrowCellModelWithtitle:@"比分直播提醒"  destVcClass:[ReminderSettingsTableViewController class]];
    IMArrowCellModel *model03 = [IMArrowCellModel IMArrowCellModelWithtitle:@"购彩定时提醒"  destVcClass:[TimerSettingsTableViewController class]];
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00,model01,model02,model03];
    [self.cells addObject:group01];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}


@end
