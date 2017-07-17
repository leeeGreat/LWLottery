//
//  HistoryController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "ForcastListCell.h"
#import "ForcastModel.h"
#import "HtmlWebVC.h"
#import "ActivityModel.h"
#import "ActivityListCell.h"
#import "HistoryController.h"
#define SEGEMENTH 30

@interface HistoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,weak)UITableView *forcastTableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@property (nonatomic,strong) NSMutableArray *forcastMArray;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;

@end

@implementation HistoryController
{
    UISegmentedControl *segment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view1.hidden = NO;
    self.view2.hidden = YES;
    
    
    //添加分段 control
    [self addsegements];
    

    // Do any additional setup after loading the view from its nib.
    NSLog(@"historycontroller");
//    self.titleLabel.text = @"发现";
    self.titleLabel.hidden = YES;
    self.titleView.backgroundColor = UIColorFromRGB(NAV_BAR_COLOR);

    [self getActivityData];
    self.tableView;
    self.forcastTableView;
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
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [self.view1 addSubview:tableView];
        
        
        
    }
    return _tableView;
}
- (UITableView *)forcastTableView
{
    if (!_forcastTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        _forcastTableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [self.view2 addSubview:tableView];
        
        
        
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
    if (tableView==_tableView) {
        if (_mArray.count>0) {
            return _mArray.count;
        }

    }
    else
    {
        if (_forcastMArray.count>0) {
            return _forcastMArray.count;
        }

    }
    return 0;
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.textLabel.text = @"123123";
//    return cell;
    
    
    
    if (tableView==_tableView) {
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
    else
    {
        static NSString *identifier = @"ForcastListCell";
        NSString *nibNameStr = @"ForcastListCell";
        ForcastListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:nibNameStr owner:self options:nil] firstObject];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        //赋值
        ForcastModel *model = [_forcastMArray safe_objectAtIndex:indexPath.row];
        cell.model = model;
        return cell;

    }
   
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        return 150;
    }
    else
    {
        return 60;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        ActivityModel *model = [_mArray safe_objectAtIndex:indexPath.row];
        HtmlWebVC *web = [[HtmlWebVC alloc] init];
        web.urlStr = model.linkAddress;
        web.titleLabel.text = @"活动详情";
        [self.navigationController pushViewController:web animated:YES];
    }
    else
    {
        NSLog(@"点击了预测cell");
    }
    
}
#pragma tableviewDelegates

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma setter and getter
- (UIView *)view1
{
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        [self.view addSubview:_view1];
    }
    return _view1;
}

- (UIView *)view2
{
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        [self.view addSubview:_view2];
        [self addView2Subviews];
    }
    return _view2;
}

#pragma setter and getter


- (void)addsegements
{
    NSArray *array = [NSArray arrayWithObjects:@"活动",@"预测", nil];
    //初始化UISegmentedControl
    segment = [[UISegmentedControl alloc]initWithItems:array];
    [segment addTarget:self action:@selector(segmentDidChanged:) forControlEvents:UIControlEventValueChanged];
    //设置frame
    segment.frame = CGRectMake((SCREENWIDTH-200)/2, 20+7, 200, SEGEMENTH);
    //添加到视图
    [self.titleView addSubview:segment];
    
    segment.selectedSegmentIndex = 0;
}

- (void)segmentDidChanged:(UISegmentedControl *)sender
{
    NSLog(@"测试");
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"点击了活动");
        self.view1.hidden = NO;
        self.view2.hidden = YES;
    }else if (sender.selectedSegmentIndex == 1){
        [self requestForcastData];
        NSLog(@"点击了预测");
        self.view1.hidden = YES;
        self.view2.hidden = NO;
    }
    else{}
}

- (void)addView2Subviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 30)];
    scrollView.contentSize = CGSizeMake(7*60, 30);
    
    [_view2 addSubview:scrollView];
    
}

- (void)requestForcastData
{
//    http://139.196.187.18:19793/cpyc/last?lottype=1007&playtype=1039
//    http://139.196.187.18:19793/cpyc/current?lottype=1007&playtype=1039
    NSString *urlStr = @"http://139.196.187.18:19793/cpyc/last";
    NSDictionary *parmeters = @{@"lottype":@"1007",@"playtype":@"1039"};
    [NetworkTool requestAFURL:urlStr httpMethod:0 parameters:parmeters succeed:^(id json) {
        NSLog(@"jsonClass--%@",NSStringFromClass([json class]));
        NSLog(@"json--%@",json);
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
            
        }
        else if([json isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [json safe_objectForKey:@"list"];
            
            _forcastMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDic in array) {
                ForcastModel *model = [ForcastModel mj_objectWithKeyValues:tempDic];
                [_forcastMArray addObject:model];
            }
            
            [_forcastTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];

}
@end
