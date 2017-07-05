//
//  IMCellGroupModel.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IMCellGroupModel : NSObject

@property (nonatomic, copy) NSString *header;

//@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, copy) NSString *footer;

@property (nonatomic, strong) NSArray *section;

@end
