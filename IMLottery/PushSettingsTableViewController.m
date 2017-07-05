//
//  PushSettingsTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "PushSettingsTableViewController.h"
#import "IMSwitchCellModel.h"
#import "IMCellGroupModel.h"
#import "IMTableViewCell.h"

@interface PushSettingsTableViewController ()

@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation PushSettingsTableViewController

- (UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (void)settingCellsData{
    
    IMSwitchCellModel *model00 = [IMSwitchCellModel IMCellModelWithImage:[UIImage imageNamed:@"MorePush"] title:@"双色球"];
    IMSwitchCellModel *model01 = [IMSwitchCellModel IMCellModelWithImage:[UIImage imageNamed:@"MorePush"] title:@"大乐透"];
    
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00,model01];
    group01.header = @"打开设置即可在开奖后立即收到推送消息，获知开奖号码";
    [self.cells addObject:group01];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
    
    //下面这段不知道为啥取出来的总是0
    self.switchView.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"大乐透"];
    if (self.switchView.isOn) {
        NSLog(@"on");
    }else{
        NSLog(@"isoff");
    }
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    IMCellGroupModel *group= self.cells[indexPath.section];
//    IMCellModel *cell = group.section[indexPath.row];
    
    IMTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.textLabel.text);
    self.switchView = (UISwitch *)cell.accessoryView;
    [self.switchView addTarget:self action:@selector(aaaaa) forControlEvents:UIControlEventValueChanged];
    
}

- (void)aaaaa{
    NSLog(@"zhang");
}

//- (void)viewWillAppear:(BOOL)animated{
//    
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    IMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[IMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//    }
//    
//    IMCellGroupModel *group= self.cells[indexPath.section];
//    cell.model = group.section[indexPath.row];
//    
//    return cell;
//}

@end
