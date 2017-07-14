//
//  HistoryController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "HtmlWebVC.h"
#import "ActivityModel.h"
#import "ActivityListCell.h"
#import "HistoryController.h"

@interface HistoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@end

@implementation HistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"historycontroller");
    self.titleLabel.text = @"活动";
    self.titleView.backgroundColor = UIColorFromRGB(NAV_BAR_COLOR);

    [self getActivityData];
    self.tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ChangeTablebar showTableBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)getActivityData
{
    NSString *urlStr = @"http://mapi.yjcp.com/act/actList";
    NSMutableDictionary *parmeters = [[NSMutableDictionary alloc] init];
    [parmeters safe_setObj:@"0" forKey:@"pageNum"];
    [parmeters safe_setObj:@"20" forKey:@"pageSize"];
    [parmeters safe_setObj:@"31000000000" forKey:@"sid"];
    [parmeters safe_setObj:@"1" forKey:@"source"];
    [NetworkTool requestAFURL:urlStr httpMethod:0 parameters:parmeters succeed:^(id json) {
        NSLog(@"jsonClass--%@",NSStringFromClass([json class]));
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
           
        }
        else if([json isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [json safe_objectForKey:@"list"];
            
            _mArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDic in array) {
                ActivityModel *model = [ActivityModel mj_objectWithKeyValues:tempDic];
                [_mArray addObject:model];
            }
            
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {

    }];

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
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.textLabel.text = @"123123";
//    return cell;
    
    
    
    
    static NSString *identifier = @"ActivityListCell";
    NSString *nibNameStr = @"ActivityListCell";
    ActivityListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:nibNameStr owner:self options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    //赋值
    ActivityModel *model = [_mArray safe_objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityModel *model = [_mArray safe_objectAtIndex:indexPath.row];
    HtmlWebVC *web = [[HtmlWebVC alloc] init];
    web.urlStr = model.linkAddress;
    web.titleLabel.text = @"活动详情";
    [self.navigationController pushViewController:web animated:YES];
}
#pragma tableviewDelegates

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
