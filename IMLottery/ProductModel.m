//
//  ProductModel.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self != nil) {
        
        self.title = dict[@"title"];
        self.stitle = dict[@"stitle"];
        self.ID = dict[@"id"];
        self.url = dict[@"url"];
        self.icon = dict[@"icon"];
        self.customUrl = dict[@"customUrl"];
    }
    return self;
    
    
}

+ (instancetype)productWithDict:(NSDictionary *)dict{
    //注意下面的这个self最好不要用ProductModel替代，否则无法使用多态使子类调用（类型上会出错）
    return [[self alloc] initWithDict:dict];;
}

@end
