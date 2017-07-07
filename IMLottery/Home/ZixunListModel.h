//
//  ZixunListModel.h
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/7.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZixunListModel : NSObject
@property (nonatomic,strong) NSString *typeName;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *contentUrl;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *contentID;
@property (nonatomic,strong) NSString *photo;
@end
