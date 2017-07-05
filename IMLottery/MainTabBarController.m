//
//  MainTabBarController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/17.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"

@interface MainTabBarController ()<MainTabBarDelegate>

@end

@implementation MainTabBarController

#pragma mark- 系统加载页面
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //将自定义的tabBar添加到原tabBar之上
    MainTabBar *tabBar = [[MainTabBar alloc] init];
    tabBar.delegate =self;
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    //设置开启页面显示的是第几个tabBar对应的页面（tabBar显示需要在tabBar中设置）
    self.selectedIndex = 0;
}

#pragma mark- MainTabBar的代理方法传值显示相应界面
//实现MainTabBar的代理方法进行传值，控制显示页面
- (void)MainTabBar:(MainTabBar *)tabBar DidClickItemWithBtnTag:(NSInteger)tag{
    //selectedIndex是TabBarController的固有属性，通过设置该值进行控制显示的页面
    self.selectedIndex = tag;
}

#pragma mark- 系统内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
