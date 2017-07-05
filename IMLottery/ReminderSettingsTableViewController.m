//
//  ReminderSettingsTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "ReminderSettingsTableViewController.h"
#import "IMSwitchCellModel.h"
#import "IMCellGroupModel.h"
#import "IMLabelCellModel.h"

@interface ReminderSettingsTableViewController ()

@end

@implementation ReminderSettingsTableViewController
- (void)settingCellsData{
    
    IMSwitchCellModel *model00 = [IMSwitchCellModel IMCellModelWithtitle:@"提醒我关注比赛"];    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00];
    group01.footer = @"当我关注的比赛比分发生变化时，通过小弹窗或着推送进行提醒";
    [self.cells addObject:group01];
    
    IMLabelCellModel *model10 = [IMLabelCellModel IMCellModelWithtitle:@"开始时间"];
    IMCellGroupModel *group02 = [[IMCellGroupModel alloc] init];
    group02.section = @[model10];
    group02.header = @"只有在以下时间接受比赛直播提醒";
    [self.cells addObject:group02];
    
    IMLabelCellModel *model20 = [IMLabelCellModel IMCellModelWithtitle:@"开始时间"];
    IMCellGroupModel *group03 = [[IMCellGroupModel alloc] init];
    group03.section = @[model20];
    [self.cells addObject:group03];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
}
@end
