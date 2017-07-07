//
//  ActivityModel.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/7.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
@property (nonatomic,strong) NSString *activityTitle;
@property (nonatomic,strong) NSString *mapAddress;
@property (nonatomic,strong) NSString *linkAddress;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *stTime;
@property (nonatomic,strong) NSString *enTime;
@end
