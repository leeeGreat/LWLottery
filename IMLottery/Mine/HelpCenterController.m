//
//  HelpCenterController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "HtmlWebVC.h"
#import "HelpCenterController.h"
#import "LocalHtmlVC.h"
@interface HelpCenterController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@end

@implementation HelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView;
    [self dealWithJson];
}
- (void)dealWithJson
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
    
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //将JSON数据转为NSArray或NSDictionary
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dictArray---%@",dictArray);
    
    _mArray = [NSMutableArray arrayWithArray:dictArray];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH)];
        _tableView = tableView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:tableView];
        
    }
    return _tableView;
}

#pragma tableviewDelegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _mArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *lineView =[[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
    NSDictionary *tempDic = [_mArray safe_objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempDic safe_objectForKey:@"title"];
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocalHtmlVC *web = [[LocalHtmlVC alloc] init];
    NSDictionary *tempDic = [_mArray safe_objectAtIndex:indexPath.row];
    
    web.urlStr = [tempDic safe_objectForKey:@"html"];
    [self.navigationController pushViewController:web animated:YES];
}

#pragma tableviewDelegates
@end
