//
//  IMArrowCellModel.h
//  IMLottery
//
//  Created by feng-Mac on 16/8/20.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "IMCellModel.h"

@interface IMArrowCellModel : IMCellModel

@property (nonatomic, assign) Class destVcClass;

+ (instancetype)IMArrowCellModelWithImage:(UIImage *)image title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)IMArrowCellModelWithtitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
