//
//  HistoryController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "PlayInstructionController.h"
#import "ForcastListCell.h"
#import "ForcastModel.h"
#import "HtmlWebVC.h"
#import "ActivityModel.h"
#import "ActivityListCell.h"
#import "HistoryController.h"
#define SEGEMENTH 30
#define FORCASTHEADERVIEWH 80
@interface HistoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,weak)UITableView *forcastTableView;
//彩票种类
@property (nonatomic,weak)UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@property (nonatomic,strong) NSMutableArray *forcastMArray;
@property (nonatomic,strong) NSMutableArray *listMArray;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;

@end

@implementation HistoryController
{
    UISegmentedControl *segment;
    UISegmentedControl *segment_little;
    NSArray *lottypeArray;
    UILabel *firstRowLab;
    UILabel *secondRowLab;
    NSString *currentLottype;
    //预测种类
    NSMutableArray *litteMArray;
    UIScrollView *litteScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初值
    litteMArray = [NSMutableArray arrayWithObjects:@"杀三码",@"杀六码", @"杀十码",@"独胆",@"双胆",@"三胆",@"篮球杀五码",@"篮球定三码",@"篮球定五胆",@"篮球杀号",nil];
    
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
    
    
    
    
    //修改self.rightBtn的frame
    CGRect frame = self.rightBtn.frame;
    frame.size.width = 66;
    frame.origin.x = frame.origin.x-22;
    self.rightBtn.frame = frame;
    [self.rightBtn setTitle:@"大乐透" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.rightBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    
    //添加listView
    NSArray *arr = @[@"双色球",@"福彩3D",@"七乐彩",@"七星彩",@"排列三",@"排列五",@"大乐透"];
    _listMArray = [NSMutableArray arrayWithArray:arr];
    lottypeArray = @[@"1001",@"1002",@"1003",@"1004",@"1005",@"1006",@"1007"];
    //默认双色球
    [self requestForcastDataWithLottype:@"1001" playtype:@""];
    
    self.tableView;
    self.forcastTableView;
    self.listTableView;
    
    //
    NSIndexPath *indpath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_listTableView didSelectRowAtIndexPath:indpath];
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
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, FORCASTHEADERVIEWH)];
        
        _forcastTableView.tableHeaderView = headerView;
        
        //内容
        firstRowLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, SCREENWIDTH/2, 20)];
//        firstRowLab.text = @"开奖号码  191期";
        firstRowLab.textColor = [UIColor lightGrayColor];
        [headerView addSubview:firstRowLab];
        
        UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat infoBtnW = 55;
        CGFloat infoBtnH = 20;
        infoBtn.frame = CGRectMake(SCREENWIDTH-infoBtnW-15, (FORCASTHEADERVIEWH-infoBtnH)/2, 55, infoBtnH);
        infoBtn.backgroundColor = [UIColor orangeColor];
        infoBtn.layer.borderWidth=1;
        infoBtn.layer.cornerRadius = 5;
        infoBtn.layer.masksToBounds = YES;
        [infoBtn setTitle:@"玩法说明" forState:UIControlStateNormal];
        infoBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [infoBtn addTarget:self action:@selector(infoBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:infoBtn];
        
        CGFloat secondRowLabY = CGRectGetMaxY(firstRowLab.frame);
        secondRowLab = [[UILabel alloc] initWithFrame:CGRectMake(20, secondRowLabY+5, SCREENWIDTH/2, 20)];
//        secondRowLab.text = @"9 7 8";
        
        secondRowLab.textColor = [UIColor redColor];
        
        [headerView addSubview:secondRowLab];

        //添加scrollview
        CGFloat scrollViewY = CGRectGetMaxY(secondRowLab.frame)+5;
        litteScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, SCREENWIDTH, 20)];
        litteScrollView.showsVerticalScrollIndicator = NO;
        litteScrollView.showsHorizontalScrollIndicator = NO;
        litteScrollView.contentSize = CGSizeMake(2*SCREENWIDTH, 20);
        [headerView addSubview:litteScrollView];
        
        //添加segement
        
        //小的分类
        [self addLitteSegment];

        
        
        
    }
    return _tableView;
}

- (UITableView *)listTableView
{
    if (!_listTableView) {
        CGFloat tableViewX = self.rightBtn.frame.origin.x-15;
        CGFloat tableViewW = SCREENWIDTH-tableViewX;
        CGFloat tableViewH = 30;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, 0, tableViewW, tableViewH*7)];
        tableView.backgroundColor = [UIColor lightGrayColor];
        _listTableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.hidden = YES;
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
    else if(tableView==_forcastTableView)
    {
        if (_forcastMArray.count>0) {
            return _forcastMArray.count;
        }

    }
    else
    {
        if (_listMArray.count>0) {
            return _listMArray.count;
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
    else if(tableView==_forcastTableView)
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
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = [_listMArray safe_objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
   
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        return 150;
    }
    else if(tableView==_forcastTableView)
    {
        return 60;
    }
    else
    {
        return 30;
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
    else if(tableView==_forcastTableView)
    {
        NSLog(@"点击了预测cell");
    }
    else
    {
        NSLog(@"点击了第%ld个cell",indexPath.row);
        NSString *selectedTitle = [_listMArray safe_objectAtIndex:indexPath.row];
        [self.rightBtn setTitle:selectedTitle forState:UIControlStateNormal];
        _listTableView.hidden = YES;
        
        //传至并请求接口
        currentLottype = @"";
        if (lottypeArray.count>0) {
             currentLottype = [lottypeArray safe_objectAtIndex:indexPath.row];
        }
        [self requestForcastDataWithLottype:currentLottype playtype:@""];
        
        [self changeLitteMArrayWithCurrentLottype:currentLottype];
        litteScrollView.contentOffset = CGPointZero;
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
    NSArray *array = [NSArray arrayWithObjects:@"活动",@"上期测中", nil];
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
    if (sender == segment) {
        NSLog(@"测试");
        if (sender.selectedSegmentIndex == 0) {
            NSLog(@"点击了活动");
            self.view1.hidden = NO;
            self.view2.hidden = YES;
            self.rightBtn.hidden = YES;
        }else if (sender.selectedSegmentIndex == 1){
            
            NSLog(@"点击了预测");
            self.view1.hidden = YES;
            self.view2.hidden = NO;
            self.rightBtn.hidden = NO;
        }
        else{}

    }
    else
    {
        NSString *playtype = @"";
        //双色球
        if ([currentLottype isEqualToString: @"1001"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1039";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1040";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1041";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1042";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1043";
            }
            
            else if (sender.selectedSegmentIndex == 5)
            {
                playtype = @"1044";
            }
            
            else if (sender.selectedSegmentIndex == 6)
            {
                playtype = @"1045";
            }
            
            else if (sender.selectedSegmentIndex == 7)
            {
                playtype = @"1046";
            }
            
            else if (sender.selectedSegmentIndex == 8)
            {
                playtype = @"1047";
            }
            
            else if (sender.selectedSegmentIndex == 9)
            {
                playtype = @"1037";
            }

        }
        //福彩3D
        if ([currentLottype isEqualToString: @"1002"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1038";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1042";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1043";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1044";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1050";
            }
            
            else if (sender.selectedSegmentIndex == 5)
            {
                playtype = @"1052";
            }
          
        }
        //七乐彩
//        1039    杀三码
        if ([currentLottype isEqualToString: @"1003"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1039";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1040";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1041";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1042";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1043";
            }
            
        }
        
        //   七星彩
        if ([currentLottype isEqualToString: @"1004"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1055";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1056";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1057";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1058";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1059";
            }
            
            else if (sender.selectedSegmentIndex == 5)
            {
                playtype = @"1060";
            }

            else if (sender.selectedSegmentIndex == 6)
            {
                playtype = @"1061";
            }

        }
        
        //   排列三
        if ([currentLottype isEqualToString: @"1005"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1038";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1042";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1043";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1044";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1050";
            }
            
            else if (sender.selectedSegmentIndex == 5)
            {
                playtype = @"1051";
            }

            else if (sender.selectedSegmentIndex == 6)
            {
                playtype = @"1052";
            }

           
        }
        
        //   排列五
        if ([currentLottype isEqualToString: @"1006"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1050";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1051";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1052";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1053";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1054";
            }
            
        }
        
        //   大乐透
        if ([currentLottype isEqualToString: @"1007"]) {
            if (sender.selectedSegmentIndex == 0)
            {
                playtype = @"1039";
            }
            else if (sender.selectedSegmentIndex == 1)
            {
                playtype = @"1040";
            }
            else if (sender.selectedSegmentIndex == 2)
            {
                playtype = @"1041";
            }
            
            else if (sender.selectedSegmentIndex == 3)
            {
                playtype = @"1042";
            }
            
            else if (sender.selectedSegmentIndex == 4)
            {
                playtype = @"1043";
            }
            
            else if (sender.selectedSegmentIndex == 5)
            {
                playtype = @"1048";
            }
            
            else if (sender.selectedSegmentIndex == 6)
            {
                playtype = @"1049";
            }

        }

        
        [self requestForcastDataWithLottype:currentLottype playtype:playtype];
        
    }
}

- (void)addView2Subviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 30)];
    scrollView.contentSize = CGSizeMake(7*60, 30);
    
    [_view2 addSubview:scrollView];
    
}

- (void)requestForcastDataWithLottype:(NSString *)lottype playtype:(NSString *)playType
{
    
//    lottype
//    双色球   1001
//    福彩3d  1002
//    七乐彩   1003
//    七星彩  1004
//    排列三   1005
//    排列五   1006
//    大乐透   1007
//    http://139.196.187.18:19793/cpyc/last?lottype=1007&playtype=1039
//    http://139.196.187.18:19793/cpyc/current?lottype=1007&playtype=1039
    NSString *urlStr = @"http://139.196.187.18:19793/cpyc/last";
    //字典崩溃保护
    if (lottype==nil) {
        lottype = @"";
    }
    //当playType时 ""时，默认第一个
    if ([playType isEqualToString:@""]) {
        if ([lottype isEqualToString:@"1001"]) {
            playType = @"1039";
        }
        else if([lottype isEqualToString:@"1002"])
        {
            playType = @"1038";
        }
        else if([lottype isEqualToString:@"1003"])
        {
            playType = @"1039";
        }
        
        else if([lottype isEqualToString:@"1004"])
        {
            playType = @"1055";
        }
        
        else if([lottype isEqualToString:@"1005"])
        {
            playType = @"1038";
        }
        else if([lottype isEqualToString:@"1006"])
        {
            playType = @"1050";
        }
        
        else if([lottype isEqualToString:@"1007"])
        {
            playType = @"1039";
        }
        
        else
        {
            
        }

    }
    
    NSDictionary *parmeters = @{@"lottype":lottype,@"playtype":playType};
    [NetworkTool requestAFURL:urlStr httpMethod:0 parameters:parmeters succeed:^(id json) {
        NSLog(@"jsonClass--%@",NSStringFromClass([json class]));
        NSLog(@"json--%@",json);
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
            
        }
        else if([json isKindOfClass:[NSDictionary class]])
        {
            
            firstRowLab.text = [NSString stringWithFormat:@"开奖号码   %@期",[json safe_objectForKey:@"kjissue"]];
            secondRowLab.text = [json safe_objectForKey:@"kjnum"];
            
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

- (void)infoBtnDidClicked:(UIButton *)btn
{
    NSLog(@"infoBtnDidClicked");
    PlayInstructionController *playInstrucVC = [[PlayInstructionController alloc] init];
    [self.navigationController pushViewController:playInstrucVC animated:YES];
}

- (void)changeLitteMArrayWithCurrentLottype:(NSString *)lottype
{
    if ([lottype isEqualToString:@"1001"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"杀三码",@"杀六码", @"杀十码",@"独胆",@"双胆",@"三胆",@"篮球杀五码",@"篮球定三码",@"篮球定五胆",@"篮球杀号",nil];

    }
    if ([lottype isEqualToString:@"1002"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"杀二码",@"独胆",@"双胆",@"三胆",@"个位杀二码",@"十位杀二码",@"百位杀二码",nil];
        
    }

    if ([lottype isEqualToString:@"1003"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"杀三码",@"杀六码", @"杀十码",@"独胆",@"双胆",nil];
        
    }
    if ([lottype isEqualToString:@"1004"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"第一位杀二码",@"第二位杀二码", @"第三位杀二码",@"第四位杀二码",@"第五位杀二码",@"第六位杀二码",@"第七位杀二码",nil];
        
    }
    if ([lottype isEqualToString:@"1005"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"杀二码",@"独胆",@"双胆",@"三胆",@"个位杀二码",@"十位杀二码",@"百位杀二码",nil];
        
    }
    if ([lottype isEqualToString:@"1006"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"个位杀二码",@"十位杀二码",@"百位杀二码",@"千位杀二码",@"万位杀二码",nil];
        
    }
    if ([lottype isEqualToString:@"1007"]) {
        litteMArray = [NSMutableArray arrayWithObjects:@"杀三码",@"杀六码", @"杀十码",@"独胆",@"双胆",@"后区杀二码",@"后区定六码",nil];
        
    }
    
//    [_forcastTableView reloadData];

    [self addLitteSegment];
}
- (void)addLitteSegment
{
    //改变  litteScrollview的  contentsize
    litteScrollView.contentSize = CGSizeMake(litteMArray.count*100, 20);
    for (UIView *subView in litteScrollView.subviews) {
        if ([subView isKindOfClass:[UISegmentedControl class]]) {
            [subView removeFromSuperview];
        }
    }
    
    //初始化UISegmentedControl
    segment_little = [[UISegmentedControl alloc]initWithItems:litteMArray];
    [segment_little addTarget:self action:@selector(segmentDidChanged:) forControlEvents:UIControlEventValueChanged];
    
    //设置frame
    segment_little.frame = CGRectMake(0, 0, 100*litteMArray.count, 20);
    //添加到视图
    [litteScrollView addSubview:segment_little];
    segment_little.selectedSegmentIndex = 0;
}
//重写父类方法
- (void)rightBtnPress
{
    NSLog(@"rightBtnPress");
    _listTableView.hidden = !_listTableView.hidden;
}
@end
