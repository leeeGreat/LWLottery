//
//  MainTabBar.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/17.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//
#import <UIKit/UIKit.h>

@class  MainTabBar;

@protocol MainTabBarDelegate <NSObject>
@optional
- (void)MainTabBar:(MainTabBar *)tabBar DidClickItemWithBtnTag:(NSInteger)tag;
@end

@interface MainTabBar : UIView

@property (nonatomic, weak) id<MainTabBarDelegate> delegate;

@end
