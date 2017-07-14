//
//  MineController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/6.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//
#import "SettingController.h"
#import "AboutUsController.h"
#import "HelpCenterController.h"
#import "HtmlWebVC.h"
#import "MineController.h"

@interface MineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"个人中心";
    NSLog(@"minecontroller");
    self.tableView;
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
   
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *lineView =[[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
    if (indexPath.row==0) {
        cell.textLabel.text = @"清除缓存";
        UILabel *accessoryLab  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        accessoryLab.textColor = [UIColor lightGrayColor];
        accessoryLab.font = [UIFont systemFontOfSize:14];
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        float MBCache = bytesCache/1000/1000;
        NSString *numStr = [NSString stringWithFormat:@"%.2lfM",MBCache];
//        numStr = @"54.23M";
        accessoryLab.text = numStr;
        cell.accessoryView = accessoryLab;
    }
    else if (indexPath.row==1) {
        cell.textLabel.text = @"关于我们";
    }
    else if (indexPath.row==2) {
        cell.textLabel.text = @"帮助中心";
    }
    else if (indexPath.row==3) {
        cell.textLabel.text = @"马上评价";
    }
    else if (indexPath.row==4) {
        cell.textLabel.text = @"当前版本";
        NSString *version = [self getAppVersion];
        UILabel *accessoryLab  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        accessoryLab.textColor = [UIColor lightGrayColor];
        accessoryLab.font = [UIFont systemFontOfSize:14];
        accessoryLab.text =version;
        cell.accessoryView = accessoryLab;
    }
   


    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        float MBCache = bytesCache/1000/1000;
        NSString *numStr = [NSString stringWithFormat:@"清理了%.2lf M",MBCache];
         [MyToast showWithText:numStr duration:1];
        
        [_tableView reloadData];
        //异步清除图片缓存 （磁盘中的）
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [[SDImageCache sharedImageCache] clearDisk];
        });
        
        
    }
    else if(indexPath.row==1)
    {

        AboutUsController *aboutVC = [[AboutUsController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    else if(indexPath.row==2)
    {
        HelpCenterController *helpCenterVC = [[HelpCenterController alloc] init];
        [self.navigationController pushViewController:helpCenterVC animated:YES];
        
    }
    else if(indexPath.row==3)
    {
        
        NSString *myAppID = APPID;
        //跳转  appstore
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id%@?mt=8",
                         myAppID ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

- (NSString *)getAppVersion
{
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    currentVersion = [NSString stringWithFormat:@"V%@", currentVersion];
    return currentVersion;
}

//重写父类方法
- (void)rightBtnPress
{
    NSLog(@"点击了设置按钮");
    SettingController *setVC = [[SettingController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

#pragma tableviewDelegates
@end
