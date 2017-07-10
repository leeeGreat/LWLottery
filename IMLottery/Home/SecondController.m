//
//  SecondController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "HtmlWebVC.h"
#import "ZixunListMoreModel.h"
#import "ZixunMoreListCell.h"
#import "SecondController.h"

@interface SecondController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *zxListMoreMArray;
@end

@implementation SecondController
{
    NSMutableArray *mArray0;
    NSMutableArray *mArray2;
    NSMutableArray *mArray3;
    NSMutableArray *mArray4;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.titleLabel.text = @"热点资讯";
    self.tableView;
    [self requestH5_hot];
}

//请求了三个接口
- (void)requestH5_hot
{
    _zxListMoreMArray = [[NSMutableArray alloc] init];
    
//    GET /h5/hot/json_5.json
    NSString *urlStr = @"http://news.zhuoyicp.com/h5/hot/json.json";
    [NetworkTool requestAFURL:urlStr httpMethod:0 parameters:nil succeed:^(id json) {
        NSArray *array = (NSArray *)json;
        NSLog(@"json--%@",json);
        mArray0 = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDic in array) {
            NSLog(@"tempDic--%@",tempDic);
            ZixunListMoreModel *model = [ZixunListMoreModel mj_objectWithKeyValues:tempDic];
            [mArray0 addObject:model];
        }
        
        [_zxListMoreMArray addObjectsFromArray:mArray0];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

    NSString *urlStr2 = @"http://news.zhuoyicp.com/h5/hot/json_2.json";
    [NetworkTool requestAFURL:urlStr2 httpMethod:0 parameters:nil succeed:^(id json) {
        NSArray *array = (NSArray *)json;
        NSLog(@"json--%@",json);
        mArray2 = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDic in array) {
            NSLog(@"tempDic--%@",tempDic);
            ZixunListMoreModel *model = [ZixunListMoreModel mj_objectWithKeyValues:tempDic];
            [mArray2 addObject:model];
        }
        [_zxListMoreMArray addObjectsFromArray:mArray2];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

    NSString *urlStr3 = @"http://news.zhuoyicp.com/h5/hot/json_3.json";
    [NetworkTool requestAFURL:urlStr3 httpMethod:0 parameters:nil succeed:^(id json) {
        NSArray *array = (NSArray *)json;
        NSLog(@"json--%@",json);
        mArray3 = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDic in array) {
            NSLog(@"tempDic--%@",tempDic);
            ZixunListMoreModel *model = [ZixunListMoreModel mj_objectWithKeyValues:tempDic];
            [mArray3 addObject:model];
        }
        
        [_zxListMoreMArray addObjectsFromArray:mArray3];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark webviewdelegate

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
    if (_zxListMoreMArray.count>0) {
        return _zxListMoreMArray.count;
    }
    else
    {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ZixunMoreListCell";
    NSString *nibNameStr = @"ZixunMoreListCell";
    ZixunMoreListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:nibNameStr owner:self options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
    }
    
    //赋值
    ZixunListMoreModel *model = [_zxListMoreMArray safe_objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZixunListMoreModel *model = [_zxListMoreMArray safe_objectAtIndex:indexPath.row];
    HtmlWebVC *web = [[HtmlWebVC alloc] init];
    web.urlStr = model.contentUrl;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma tableviewDelegates
@end
