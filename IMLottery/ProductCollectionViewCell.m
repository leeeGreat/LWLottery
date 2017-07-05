//
//  ProductCollectionViewCell.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "ProductModel.h"

@interface ProductCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ProductCollectionViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        self.imageView.layer.cornerRadius = 10;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)setProduct:(ProductModel *)product{
    _product = product;
    
    self.label.text = product.title;

    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",product.icon];
    NSRange range = [str rangeOfString:@"@2x"];
    [str deleteCharactersInRange:range];
    
//    NSLog(@"%@",str);
    self.imageView.image = [UIImage imageNamed:str];
    
}

//注意：用于裁剪图片的这段代码不能放在init里面，因为那个时候图片还没有生成
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.masksToBounds = YES;

}



@end
