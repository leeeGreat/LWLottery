//
//  MainTabBar.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/17.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//
#define count 5
#import "MainTabBar.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "IMTabButtonBarItem.h"

@interface MainTabBar()<UITabBarControllerDelegate>

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation MainTabBar

#pragma mark- 系统加初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = [UIColor colorWithR:13 G:13 B:13 andAlpha:1];
        
        for (int i=0; i<count; i++) {
            IMTabButtonBarItem *btn = [[IMTabButtonBarItem alloc] init];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%02d_new",i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%02d_selected_new",i]] forState:UIControlStateSelected];
            btn.adjustsImageWhenHighlighted = NO;
            btn.tag = i;
            [btn addTarget:self action:@selector(BtnDidClicked:) forControlEvents:UIControlEventTouchDown];
            //设置第一次进入时候选中第0个按钮
            if(i == 0 ){
                [self BtnDidClicked:btn];
            }
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)BtnDidClicked:(UIButton *)button{
    //设置按钮选中状态
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    //切换控制器
    if([self.delegate respondsToSelector:@selector(MainTabBar:DidClickItemWithBtnTag:)]){
        [self.delegate MainTabBar:self DidClickItemWithBtnTag:button.tag];
    }
    
}

- (void)layoutSubviews{
    
    for (int i=0; i<count; i++) {
        
        CGFloat x = self.width/count*i;
        CGFloat y = 0;
        CGFloat width =  self.width/count;
        CGFloat height =  self.height;
        
        self.subviews[i].frame = CGRectMake(x, y, width, height);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
