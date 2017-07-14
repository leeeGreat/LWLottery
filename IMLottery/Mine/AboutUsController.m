//
//  AboutUsController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/14.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    APPID @"1258043960"   256彩票
    if ([APPID isEqualToString:@"1258043960"]) {
         self.nameLab.text = @"256彩票";
        self.contentText.text = @"256彩票是由二五六独家推出、业内稳定保证的彩票专业投注软件，本软件功能强大，安全方面、界面美观、更省流量，让您随时随地投注彩票，是您最好的一款APP伴侣。";
    }
    else if([APPID isEqualToString:@"1258547113"])
    {
        self.nameLab.text = @"PC蛋蛋";
        self.contentText.text = @"PC蛋蛋是一种竞猜游戏。开奖号码为三个（0－9）中随机产生的数字之和，总共有28种结果（0－27）。这28个号码，押中即可获得奖励。每天从早上9:05至23:55，每5分钟一期。虽然游戏本身规则很简单，但由于每期都有几万人一起投注，而且投注的号码和金蛋各不相同，所以每个号码会有不同赔率。";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
