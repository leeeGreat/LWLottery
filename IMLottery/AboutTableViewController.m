//
//  AboutTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "AboutTableViewController.h"
#import "IMArrowCellModel.h"
#import "IMCellGroupModel.h"
#import "IMTableViewCell.h"


@interface AboutTableViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AboutTableViewController

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)settingCellsData{
    
    IMArrowCellModel *model00 = [IMArrowCellModel IMCellModelWithtitle:@"评价支持"];
    model00.imBlock = ^(){
        NSString *str = @"725296055";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",str]]];
    };
    
    IMArrowCellModel *model01 = [IMArrowCellModel IMCellModelWithTitle:@"客户电话" subTitle:@"10010"];
    model01.imBlock = ^(){
        //方法一，直接拨打电话
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10010"]];
        
//        方法二，用webView间接拨打（提示拨打，经确认才回拨号，并在结束后回到App）
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10010"]]];
        
    };
    
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    
    UIView *imview = [[[NSBundle mainBundle] loadNibNamed:@"AboutHeaderView" owner:nil options:nil] lastObject];
    self.tableView.tableHeaderView = imview;
    
    group01.section = @[model00,model01];
    [self.cells addObject:group01];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
    
}

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    //卧槽，原来这一句可以不写
////    view.frame = CGRectMake(0, 0, 375, 237);
//}

@end
