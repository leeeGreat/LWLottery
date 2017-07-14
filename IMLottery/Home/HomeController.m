//
//  HomeController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "MessageController.h"
#import "ActivityView.h"
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
    UIView *maskView;
    UIWebView *homeWeb;
    UIPageControl *pageControl;
    NSTimer *rotateTimer;
    UIScrollView *lunboScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"消息" forState:UIControlStateNormal];
    
    [self requestAnalysize];
    // Do any additional setup after loading the view from its nib.
    self.tableView;
    
    self.titleLabel.text = @"首页";
     self.titleView.backgroundColor = UIColorFromRGB(NAV_BAR_COLOR);
//    [self requestHomeInfo];
    
    //第一次请求接口
    [self tryToLoad];
    //网络监听，网络变化时再次请求接口
    [self startToListenNow];
    
    [self addMaskView];
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

    
    [NetworkTool requestAFURL:BASEURL httpMethod:0 parameters:nil succeed:^(id json) {
//        NSDictionary *dic=
//  @{@"appid":@"jiuwcomceshi",@"appname":@"\u6d4b\u8bd5\u7528",@"isshowwap":@"1",@"wapurl":@"http://vip.9w100.com/",@"status":@(1),@"desc":@"\u6210\u529f\u8fd4\u56de\u6570\u636e"};
//        json = [NSDictionary dictionaryWithDictionary:dic];
//        json = nil;
        
        if ([json isKindOfClass:[NSString class]]||json ==nil||[json  isEqual:[NSNull null]]) {
            maskView.hidden = YES;
            homeWeb.hidden = YES;
            [self requestHomeInfo];
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
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
                    [self performSelector:@selector(removeActivityView) withObject:nil afterDelay:TIMEOUT];
                    [homeWeb loadRequest:request];
                    
                    maskView.hidden = NO;
                    homeWeb.hidden = NO;
                    //显示引导页
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"addLauchImageView" object:nil];
                    
                    [ChangeTablebar hiddenTableBar];
                }
                else
                {
                    //加载自己的页面
                    
                    maskView.hidden = YES;
                    homeWeb.hidden = YES;
                    [self requestHomeInfo];
                    [ChangeTablebar showTableBar];
                    self.url = @"";
                }
            }

        }
        
        
        
        
    } failure:^(NSError *error) {
        //加载自己的页面
        maskView.hidden = YES;
        homeWeb.hidden = YES;
        [self requestHomeInfo];
        [ChangeTablebar showTableBar];
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


#pragma mark webviewdelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[ActivityView shareAcctivity] showActivity];
}
//webview加载失败，则reload
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    NSLog(@"didFailLoadWithError--%@",error);
    [[ActivityView shareAcctivity] hiddeActivity];
    //
    // 如果是被取消，什么也不干
    if([error code] == NSURLErrorCancelled)  {
        return;
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]
                             
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                             
                                              timeoutInterval:TIMEOUT];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
    [self performSelector:@selector(removeActivityView) withObject:nil afterDelay:TIMEOUT];
    [homeWeb loadRequest:request];

    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     [[ActivityView shareAcctivity] hiddeActivity];
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
    return 170;
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
- (void)addMaskView
{
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEN_HEIGHT)];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maskView];
    maskView.hidden = NO;
}

- (void)addHomeWebView
{
    NSLog(@"homecontroller");
    
    homeWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEN_HEIGHT)];
    homeWeb.scalesPageToFit = YES;
    homeWeb.delegate = self;
    [self.view addSubview:homeWeb];
    homeWeb.hidden = YES;

}

- (void)addHeaderView
{
    NSInteger iconsCount = _lunboListMArray.count;
    
    
    //test
//    [_lunboListMArray removeObjectsInRange:NSMakeRange(1, iconsCount-1)];
//    iconsCount = _lunboListMArray.count;
//    NSLog(@"_lunboListMArray--%@",_lunboListMArray);
    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    
    //添加轮播图
    lunboScrollView = [[UIScrollView alloc] initWithFrame:headerView.bounds];
    lunboScrollView.delegate = self;
    
    lunboScrollView.showsVerticalScrollIndicator = NO;
    lunboScrollView.showsHorizontalScrollIndicator = NO;
    lunboScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*iconsCount, 100);
    lunboScrollView.pagingEnabled = YES;

    NSLog(@"iconsCount--%ld",iconsCount);
    for (int i=0; i<iconsCount; i++) {
        LunboListModel *model = [_lunboListMArray safe_objectAtIndex:i];
        NSLog(@"iconUrlStr--%@",model.mapAddress);
        UIImageView *lunboIconView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, 100)];
        
        if (i==iconsCount) {
             LunboListModel *modelLast = [_lunboListMArray safe_objectAtIndex:0];
             [lunboIconView sd_setImageWithURL:[NSURL URLWithString:modelLast.mapAddress]];
            lunboIconView.tag = 0+100;
        }
        else
        {
             [lunboIconView sd_setImageWithURL:[NSURL URLWithString:model.mapAddress]];
            lunboIconView.tag = i+100;
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
    if (iconsCount<=1) {
        
    }
    else
    {
        [self addTimer];
    }
    
    
    
    
    
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
    pageControl.currentPage = scrollView.contentOffset.x/SCREENWIDTH;
    
}



#pragma uiscrollviewDelegate

- (void)nextImage
{
    int page = lunboScrollView.contentOffset.x/SCREENWIDTH;
//    NSLog(@"page--%d",page);
    if (page==_lunboListMArray.count) {
        page = 0;
    }
    else
    {
        page++;
    }
    
    CGFloat x = page*lunboScrollView.frame.size.width;
    
   
    if (x==SCREENWIDTH*(_lunboListMArray.count)) {
        lunboScrollView.contentOffset = CGPointMake(0, 0);
        pageControl.currentPage = 0;
    }
    else
    {
        lunboScrollView.contentOffset = CGPointMake(x, 0);
        pageControl.currentPage = x/SCREENWIDTH;
    }

    
    
    
    
//    CGPoint point = lunboScrollView.contentOffset;
//    if (point.x==(_lunboListMArray.count-1)*SCREEN_WIDTH) {
////        lunboScrollView.contentOffset = CGPointMake(0, 0);
//        [UIView animateWithDuration:0.5 animations:^{
//            lunboScrollView.contentOffset = CGPointMake(point.x+SCREEN_WIDTH, point.y);
//        }];
//
//    }
//    else
//    {
//        [UIView animateWithDuration:0.5 animations:^{
//            lunboScrollView.contentOffset = CGPointMake(point.x+SCREEN_WIDTH, point.y);
//        }];
//    }

    
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

- (void)removeActivityView
{
    [[ActivityView shareAcctivity] hiddeActivity];
}

- (void)requestAnalysize
{
//    http://client.310win.com/Default.aspx?transcode=922&deviceid=1352442&client=2&version=4.0
//    msg	{"Params":{"articletype":0},"pageindex":"1"}
//    msg	{"pageindex":"1"}
    NSString *urlStr = @"http://client.310win.com/Default.aspx?transcode=922&deviceid=1352442&client=2&version=4.0";
    NSDictionary *params = @{@"articletype":@(0),@"pageindex":@"1"};
    [NetworkTool requestAFURL:urlStr httpMethod:1 parameters:params succeed:^(id json) {
        NSLog(@"json--%@",json);
    } failure:^(NSError *error) {
        
    }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
 //    [self.timer invalidate];
     [self removeTimer];
}

 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
 //    开启定时器
     [self addTimer];
}

 /**
    100  *  开启定时器
    101  */
- (void)addTimer{

    rotateTimer= [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
 /**
     108  *  关闭定时器
     109  */
 - (void)removeTimer
 {
    [rotateTimer invalidate];
 }

//重写父view的方法
- (void)rightBtnPress
{
    NSLog(@"rightBtnPress");
    MessageController *messageVC = [[MessageController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

@end
