//
//  HomeController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "SecondController.h"
#import "ZixunlistCell.h"
#import "HtmlWebVC.h"
#import "ZixunListModel.h"
#import "LunboListModel.h"
#import "LottoryListModel.h"
#import "HomeController.h"
//webview请求超时时间
#define TIMEOUT 10
@interface HomeController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSString *url;
//轮播，彩票，资讯
@property (nonatomic,strong) NSMutableArray *lunboListMArray;
@property (nonatomic,strong) NSMutableArray *lotteryListMArray;
@property (nonatomic,strong) NSMutableArray *zxListMArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HomeController
{
    UIWebView *homeWeb;
    UIPageControl *pageControl;
    NSTimer *rotateTimer;
    UIScrollView *lunboScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView;
    
    self.titleLabel.text = @"首页";
     self.titleView.backgroundColor = UIColorFromRGB(NAV_BAR_COLOR);
    [self requestHomeInfo];
    
    //第一次请求接口
    [self tryToLoad];
    //网络监听，网络变化时再次请求接口
    [self startToListenNow];
    
    [self addHomeWebView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //navbar不透明
//    self.navigationController.navigationBar.translucent = NO;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)requestHomeInfo
{
    NSString *urlStr = @"http://mapi.yjcp.com/center/homePageInfo";
    //nil时行不行？
    [NetworkTool requestAFURL:urlStr httpMethod:0 parameters:nil succeed:^(id json) {
        NSLog(@"jsonClass--%@",NSStringFromClass([json class]));
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
            
        }
        else if([json isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [json safe_objectForKey:@"lotterylist"];
            _lotteryListMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDic in array) {
                LottoryListModel *model = [LottoryListModel mj_objectWithKeyValues:tempDic];
                [_lotteryListMArray addObject:model];
            }
            
//            lunboList
            NSArray *array2 = [json safe_objectForKey:@"lunboList"];
            _lunboListMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDic in array2) {
                 LunboListModel *model = [LunboListModel mj_objectWithKeyValues:tempDic];
                [_lunboListMArray addObject:model];
            }
            [self addHeaderView];
            
            //            zxList
            NSArray *array3 = [json safe_objectForKey:@"zxList"];
            _zxListMArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDic in array3) {
                ZixunListModel *model = [ZixunListModel mj_objectWithKeyValues:tempDic];
                [_zxListMArray addObject:model];
            }


            
            
            
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];

}
- (void)requestGetAboutUs
{

    //test
//    {"appid":"jiuwcomceshi","appname":"\u6d4b\u8bd5\u7528","isshowwap":"1","wapurl":"http://vip.9w100.com/","status":1,"desc":"\u6210\u529f\u8fd4\u56de\u6570\u636e"}
    [NetworkTool requestAFURL:BASEURL httpMethod:0 parameters:nil succeed:^(id json) {
//        NSDictionary *dic=
//  @{@"appid":@"jiuwcomceshi",@"appname":@"\u6d4b\u8bd5\u7528",@"isshowwap":@"1",@"wapurl":@"http://vip.9w100.com/",@"status":@(1),@"desc":@"\u6210\u529f\u8fd4\u56de\u6570\u636e"};
//        json = [NSDictionary dictionaryWithDictionary:dic];
        json = nil;
        
        
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
            homeWeb.hidden = YES;
        }
        else if([json isKindOfClass:[NSDictionary class]])
        {
            NSNumber *status = [json safe_objectForKey:@"status"];
            NSString *isshowwap = [json safe_objectForKey:@"isshowwap"];
            NSString * wapurl = [json safe_objectForKey:@"wapurl"];
            //1 成功  0失败
            if ([status integerValue]==1) {
                if ([isshowwap isEqualToString:@"1"]) {
                    //加载wapurl
                    self.url = wapurl;
                    
                    
                    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]
                                             
                                                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             
                                                              timeoutInterval:TIMEOUT];
                    [homeWeb loadRequest:request];
                    
                    
                    homeWeb.hidden = NO;
                    [ChangeTablebar hiddenTableBar];
                }
                else
                {
                    //加载自己的页面
                    homeWeb.hidden = YES;
                    [ChangeTablebar showTableBar];
                    self.url = @"";
                }
            }

        }
        
        
        
        
    } failure:^(NSError *error) {
        self.url = @"";
    }];

}



//网络监听
-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [self tryToLoad];
            }
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tryToLoad
{
    [self requestGetAboutUs];
}
//请求方式
//-(void)tryToLoad {
//    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
//    request.timeoutInterval = 5.0;
//    request.HTTPMethod = @"post";
//    
//    NSString *param = [NSString stringWithFormat:@"appid=%@",@"cbapp102"];
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLResponse *response;
//    NSError *error;
//    NSData *backData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (error) {
//        //[self setupContentVC];
//        self.url = @"";
//        [self createHtmlViewControl];
//    }else{
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
//        
//        NSLog(@"dic======%@",dic);
//        if ([[dic objectForKey:@"status"] intValue]== 1) {
//            NSLog(@"获取数据成功%@%@",[dic objectForKey:@"desc"],[dic objectForKey:@"appname"]);//
//            self.url =  ([[dic objectForKey:@"isshowwap"] intValue]) == 1?[dic objectForKey:@"wapurl"] : @"";
//            //self.url = @"http://www.baidu.com";
//            //               self.url = @"http://www.11c8.com/index/index.html?wap=yes&appid=c8app16";
//            if ([self.url isEqualToString:@""]) {
//                //[self setupContentVC];
//                self.url = @"";
//                [self createHtmlViewControl];
//            }else{
//                [self createHtmlViewControl];
//            }
//        }else if ([[dic objectForKey:@"status"] intValue]== 2) {
//            NSLog(@"获取数据失败");
//            //[self setupContentVC];
//            self.url = @"";
//            [self createHtmlViewControl];
//        }else{
//            //[self setupContentVC];
//            self.url = @"";
//            [self createHtmlViewControl];
//        }
//    }
//}


#pragma mark webviewdelegate
//webview加载失败，则reload
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError--%@",error);
//    [webView reload];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]
                             
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                             
                                              timeoutInterval:TIMEOUT];
    [homeWeb loadRequest:request];

    
}
#pragma mark webviewdelegate

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH-TABBARH)];
        _tableView = tableView;
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
//    return _zxListMArray.count;
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.textLabel.text = @"123123";
//        return cell;
    
    
    
    
    static NSString *identifier = @"ZixunlistCell";
    NSString *nibNameStr = @"ZixunlistCell";
    ZixunlistCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:nibNameStr owner:self options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    //赋值
    ZixunListModel *model = [_zxListMArray safe_objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZixunListModel *model = [_zxListMArray safe_objectAtIndex:indexPath.row];
    HtmlWebVC *web = [[HtmlWebVC alloc] init];
    web.urlStr = model.contentUrl;
    [self.navigationController pushViewController:web animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UIButton *loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadMoreBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
    [loadMoreBtn addTarget:self action:@selector(loadMoreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loadMoreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [loadMoreBtn setTitle:@"加载更多。。" forState:UIControlStateNormal];
    [footerView addSubview:loadMoreBtn];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
#pragma tableviewDelegates

- (void)addHomeWebView
{
    NSLog(@"homecontroller");
    
    homeWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEN_HEIGHT)];
    
    homeWeb.delegate = self;
    [self.view addSubview:homeWeb];
    homeWeb.hidden = YES;

}

- (void)addHeaderView
{
    NSInteger iconsCount = _lunboListMArray.count;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    
    //添加轮播图
    lunboScrollView = [[UIScrollView alloc] initWithFrame:headerView.bounds];
    lunboScrollView.delegate = self;
    
    lunboScrollView.showsVerticalScrollIndicator = NO;
    lunboScrollView.showsHorizontalScrollIndicator = NO;
    lunboScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*iconsCount, 100);
    lunboScrollView.pagingEnabled = YES;

    NSLog(@"iconsCount--%ld",iconsCount);
    for (int i=0; i<iconsCount+1; i++) {
        LunboListModel *model = [_lunboListMArray safe_objectAtIndex:i];
        NSLog(@"iconUrlStr--%@",model.mapAddress);
        UIImageView *lunboIconView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, 100)];
        lunboIconView.tag = i+100;
        if (i==iconsCount) {
             LunboListModel *modelLast = [_lunboListMArray safe_objectAtIndex:0];
             [lunboIconView sd_setImageWithURL:[NSURL URLWithString:modelLast.mapAddress]];
        }
        else
        {
             [lunboIconView sd_setImageWithURL:[NSURL URLWithString:model.mapAddress]];
        }
        
        //imageView添加点击手势
        lunboIconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconViewAction:)];
        tap.delegate = self;
        [lunboIconView addGestureRecognizer:tap];
        
        
        
        
        [lunboScrollView addSubview:lunboIconView];
    }
    
    
    [headerView addSubview:lunboScrollView];
    //添加UIPageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 100-10, SCREEN_WIDTH, 5)];
    pageControl.numberOfPages = iconsCount;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [headerView addSubview:pageControl];
    
    
    //启动定时器
    rotateTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeScrollViewOffset) userInfo:nil repeats:YES];
    
    
    
    
     _tableView.tableHeaderView = headerView;
    if (iconsCount<=0) {
       _tableView.tableHeaderView = nil;
    }
    
}
//- (void)addFooterView
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
//    footerView.backgroundColor = [UIColor purpleColor];
//    UIButton *loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loadMoreBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
//    [loadMoreBtn addTarget:self action:@selector(loadMoreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [loadMoreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [loadMoreBtn setTitle:@"加载更多。。" forState:UIControlStateNormal];
//    [footerView addSubview:loadMoreBtn];
//    _tableView.tableFooterView = footerView;
//}
#pragma uiscrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    if (page==_lunboListMArray.count) {
        page = 0;
    }
    
    // 设置页码
    pageControl.currentPage = page;
}


#pragma uiscrollviewDelegate

- (void)changeScrollViewOffset
{
    CGPoint point = lunboScrollView.contentOffset;
    if (point.x>=(_lunboListMArray.count)*SCREEN_WIDTH) {
        lunboScrollView.contentOffset = CGPointMake(0, 0);
        [UIView animateWithDuration:0.5 animations:^{
            lunboScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }];

    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            lunboScrollView.contentOffset = CGPointMake(point.x+SCREEN_WIDTH, point.y);
        }];
    }

    
}

- (void)dealloc
{
    //释放定时器
    [rotateTimer invalidate];
}

- (void)tapIconViewAction:(UITapGestureRecognizer *)tap
{
    UIImageView *iconView = (UIImageView *)tap.view;
    NSInteger loctionIdx = iconView.tag-100;
    
    LunboListModel *model = [_lunboListMArray safe_objectAtIndex:loctionIdx];
    HtmlWebVC *web = [[HtmlWebVC alloc] init];
    web.urlStr = model.linkAddress;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)loadMoreBtnDidClicked:(UIButton *)btn
{
    SecondController *secondVC = [[SecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
