//
//  IMWebModel.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/22.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMWebModel.h"

@implementation IMWebModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.html = dict[@"html"];
        self.ID = dict[@"id"];
    }
    return self;
}

+ (instancetype)webWitDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
    
}

@end
