//
//  MessageController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/14.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView;
    self.titleLabel.text = @"消息列表";
    NSArray *array = @[@"最新活动来了，注册就送大礼包",@"最新活动来了，注册就送大礼包",@"大奖是守出来的，你今天坚持了吗？",@"签到送福袋了，快快快，好礼不能停",@"签到送福袋了，快快快，好礼不能停",@"码上有惊喜，快来扫一扫了",@"最新版app来了，请及时更新，以免影响使用",@"今天是你的幸运日，你买彩票了吗？",@"专家预测，超准命中率，还不来！"];
    _mArray = [NSMutableArray arrayWithArray:array];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        _tableView = tableView;
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
    if (_mArray.count>0) {
        return _mArray.count;
    }
    else
    {
        return 5;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSString *str = [_mArray safe_objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
        return cell;
  
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
