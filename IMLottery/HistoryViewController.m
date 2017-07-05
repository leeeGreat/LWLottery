//
//  HistoryViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/19.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "HistoryViewController.h"
#import "UIColor+Extension.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIView *IMView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    
//    UIView *view = [[NSBundle mainBundle] pathForResource:@"AboutHeaderView.xib" ofType:nil];
//    UINib *nib = [UINib nibWithNibName:@"AboutHeaderView" bundle:nil];
//    
//    IMView *view01 = [[IMView alloc] init];
//    [self.IMView addSubview:view01];
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
