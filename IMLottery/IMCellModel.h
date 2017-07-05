//
//  IMCellModel.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^IMBlock)();

@interface IMCellModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) IMBlock imBlock;


+ (instancetype)IMCellModelWithtitle:(NSString *)title;
+ (instancetype)IMCellModelWithTitle:(NSString *)title subTitle:(NSString *)subtitle;
+ (instancetype)IMCellModelWithImage:(UIImage *)image title:(NSString *)title;


@end
