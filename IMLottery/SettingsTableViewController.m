//
//  SettingsTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "PushTableViewController.h"
#import "IMCellGroupModel.h"
#import "IMArrowCellModel.h"
#import "IMSwitchCellModel.h"
#import "NewVersionTableViewController.h"
#import "HelpTableViewController.h"
#import "ShareTableViewController.h"
#import "MessageTableViewController.h"
#import "ProductsCollectionViewController.h"
#import "AboutTableViewController.h"
#import "MBProgressHUD+MJ.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self settingCellsData];
    
    
}

- (void)settingCellsData{
    
    IMArrowCellModel *model00 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MorePush"] title:@"推送和提醒"  destVcClass:[PushTableViewController class]];
    IMSwitchCellModel *model01 = [IMSwitchCellModel IMCellModelWithImage:[UIImage imageNamed:@"more_homeshake"] title:@"摇一摇机选"];
    IMSwitchCellModel *model02 = [IMSwitchCellModel IMCellModelWithImage:[UIImage imageNamed:@"sound_Effect"] title:@"声音效果"];
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00,model01,model02];
//    group01.header = @"zhangdanfeng is the king of the world;";
//    group01.footer = @"yeh, you are right";
    [self.cells addObject:group01];
    
    IMCellModel *model10 = [IMCellModel IMCellModelWithImage:[UIImage imageNamed:@"MoreUpdate"] title:@"检查新版本"];
    model10.imBlock = ^{
        [MBProgressHUD showMessage:@"checking"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"No Update for your phone"];
        });
    
    };
    
    IMArrowCellModel *model11 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MoreHelp"] title:@"帮助" destVcClass:[HelpTableViewController class]];
    IMArrowCellModel *model12 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MoreShare"] title:@"分享" destVcClass:[ShareTableViewController class]];
    IMArrowCellModel *model13 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MoreMessage"] title:@"查看消息" destVcClass:[MessageTableViewController class]];
    IMArrowCellModel *model14 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MoreNetease"] title:@"产品推荐" destVcClass:[ProductsCollectionViewController class]];
    IMArrowCellModel *model15 = [IMArrowCellModel IMArrowCellModelWithImage:[UIImage imageNamed:@"MoreAbout"] title:@"关于" destVcClass:[AboutTableViewController class]];
    IMCellGroupModel *group02 = [[IMCellGroupModel alloc] init];
    group02.section = @[model10,model11,model12,model13,model14,model15];
//    group02.header = @"zhangdanfeng rules the world";
//    group02.footer = @"yeh, you are right";
    [self.cells addObject:group02];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"jkldjfskl;dajfads;lfjkdas;kl///////");
}


@end
