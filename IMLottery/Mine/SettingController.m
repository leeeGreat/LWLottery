//
//  SettingController.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/14.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *mArray;
@end

@implementation SettingController
{
    BOOL swithIsOn;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    swithIsOn = [self judeNotificationSwitchOnOrOff];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBtn.hidden = NO;
    CGRect frame = self.rightBtn.frame;
    frame.size.width = 66;
    frame.origin.x = frame.origin.x-22;
    self.rightBtn.frame = frame;
    [self.rightBtn setTitle:@"去打开" forState:UIControlStateNormal];

    self.tableView.hidden = NO;
    // Do any additional setup after loading the view.
    NSArray *array = @[@"推送开关"];
    _mArray = [NSMutableArray arrayWithArray:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREEN_HEIGHT-NAVBARH)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = [_mArray safe_objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    
    if (indexPath.row==0&&indexPath.section==0) {
        UISwitch* mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(200.0,10.0,0.0,0.0)];
        
        NSLog(@"isON---%ld",swithIsOn);
        [mySwitch setOn:swithIsOn];
        mySwitch.userInteractionEnabled = NO;
        cell.accessoryView = mySwitch;
        self.rightBtn.hidden = swithIsOn;
    }
    return cell;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma uitableviewdelegate

- (BOOL )judeNotificationSwitchOnOrOff
{
    NSLog(@"kaiguan----%lu",(unsigned long)[[UIApplication sharedApplication] currentUserNotificationSettings].types);
    if (IOS_VERSION>=8.0) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
            return NO;
        }
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone) {
            return NO;
        }
        
}
    return YES;
}



//重写父类方法
- (void)rightBtnPress
{
    NSLog(@"点击了去打开按钮");
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL *url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

@end
