//
//  ProductsCollectionViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "ProductsCollectionViewController.h"
#import "ProductModel.h"
#import "ProductCollectionViewCell.h"

@interface ProductsCollectionViewController ()

@property (nonatomic, strong) NSArray *products;

@end

@implementation ProductsCollectionViewController

static NSString * const reuseIdentifier = @"product";

- (NSArray *)products{
    if (_products == nil) {
//        _products = [NSArray array];
        
        NSMutableArray *output = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more_project.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSArray *input = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",input);
        
        for (NSDictionary *dict in input) {
            ProductModel *product = [ProductModel productWithDict:dict];
            [output addObject:product];
        }
        _products = output;
    }
    return _products;
}

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局的基本属性以控制显示效果
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(80, 80);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UINib *nib = [UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    cell.product = self.products[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *product = self.products[indexPath.item];
    UIApplication *application = [UIApplication sharedApplication];
    NSString *str = [NSString stringWithFormat:@"%@://%@", product.customUrl,product.ID];
    NSURL *url = [NSURL URLWithString:str];
    if ([application canOpenURL:url]) {
        [application openURL:url];
    }else{
        
        [application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",product.url]]];
    }
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
