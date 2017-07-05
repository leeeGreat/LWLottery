//
//  LotteryHallViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/19.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "LotteryHallViewController.h"
#import "UIColor+Extension.h"
#import "IMNavButtonBarItem.h"

@interface LotteryHallViewController ()

@end

@implementation LotteryHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
