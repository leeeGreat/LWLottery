//
//  IMArrowCellModel.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMArrowCellModel.h"

@implementation IMArrowCellModel

+ (instancetype)IMArrowCellModelWithImage:(UIImage *)image title:(NSString *)title destVcClass:(__unsafe_unretained Class)destVcClass{
    //不知道为什么第一句就不行，如果用第一句那么后面setting中的所有cell返回的都是IMCellModel类型而不是两种自类型，weird；现在知道了
    IMArrowCellModel *model = [[self alloc] init];
    model.image = image;
    model.title = title;
    model.destVcClass = destVcClass;
    return model;
}

+ (instancetype)IMArrowCellModelWithtitle:(NSString *)title destVcClass:(Class)destVcClass{
    IMArrowCellModel *model = [[self alloc] init];
    model.title = title;
    model.destVcClass = destVcClass;
    return model;
}


@end
