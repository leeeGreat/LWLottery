//
//  IMNavButtonBarItem.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/19.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMNavButtonBarItem.h"
#import "UIView+Extension.h"

@interface IMNavButtonBarItem()

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect imageF;

@end

@implementation IMNavButtonBarItem

//代码创建才会调用，生命周期内只会调用一次
- (instancetype)init{
    return [super init];
}

//IB创建调用，但是内部的frame都为0，因为还没有创建，生命周期内只会调用一次
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [super initWithCoder:aDecoder];
}

//init的内部实现，代码创建才会调用，生命周期内只会调用一次
- (instancetype)initWithFrame:(CGRect)frame{
    return [super initWithFrame:frame];
}

//不知道这个是干嘛用的，一直未调用
- (CGRect)backgroundRectForBounds:(CGRect)bounds{
    return [super backgroundRectForBounds:bounds];
}

//合并创建title和image，如果实现该方法下面两个方法中的rect则为0；
- (CGRect)contentRectForBounds:(CGRect)bounds{
    return [super contentRectForBounds:bounds];
}

//单独实现title布局，在没有实现合并创建的方法（也就是上面的方法）时，rect不为0
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect frame = [super titleRectForContentRect:contentRect];
    self.titleF = frame;
//    NSLog(@"titleRect----%@",NSStringFromCGRect(self.titleF));
//    NSLog(@"contentRect----%@",NSStringFromCGRect(contentRect));
    
    CGFloat edge = (contentRect.size.width - frame.size.width - self.imageF.size.width)/2;
    CGFloat x = edge;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    return CGRectMake(x, y, w, h);
}

//单独实现image布局，在没有实现合并创建的方法（也就是上面的方法）时，rect不为0
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGRect frame = [super imageRectForContentRect:contentRect];
    self.imageF = frame;
//    NSLog(@"%@",NSStringFromCGRect(self.imageF));
    
    CGFloat edge = (contentRect.size.width - self.titleF.size.width - frame.size.width)/2;
    CGFloat x = self.titleF.size.width + edge;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    return CGRectMake(x, y, w, h);
}



@end
