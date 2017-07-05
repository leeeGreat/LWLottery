//
//  IMWebModel.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/22.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMWebModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)webWitDict:(NSDictionary *)dict;

@end
