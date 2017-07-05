//
//  IMCellModel.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMCellModel.h"

@implementation IMCellModel

+ (instancetype)IMCellModelWithtitle:(NSString *)title{
    //创建的时候用self，不要用［IMCellModel alloc］
    IMCellModel *model = [[self alloc] init];
    model.title = title;
    return model;
}

+ (instancetype)IMCellModelWithTitle:(NSString *)title subTitle:(NSString *)subtitle{
    IMCellModel *model = [self IMCellModelWithtitle:title];
    model.subtitle = subtitle;
    return model;
}

+ (instancetype)IMCellModelWithImage:(UIImage *)image title:(NSString *)title{
    //创建的时候用self，不要用［IMCellModel alloc］
    IMCellModel *model = [self IMCellModelWithtitle:title];
    model.image = image;
    return model;
    
}

@end
