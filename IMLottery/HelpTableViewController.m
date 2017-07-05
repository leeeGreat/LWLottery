//
//  HelpTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "HelpTableViewController.h"
#import "IMArrowCellModel.h"
#import "IMCellGroupModel.h"
#import "WebViewController.h"
#import "IMWebModel.h"
#import "MainNavViewController.h"

@interface HelpTableViewController ()

@property (nonatomic, strong) NSMutableArray *webs;

@end

@implementation HelpTableViewController

- (NSMutableArray *)webs{
    if (_webs == nil) {
        _webs = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSArray *webs = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray *output = [NSMutableArray array];
        
        for (NSDictionary *dict in webs) {
            
            IMWebModel *web = [IMWebModel webWitDict:dict];
            [output addObject:web];
        }
        _webs = output;
    }
    return _webs;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (IMWebModel *web in self.webs) {
        
        IMArrowCellModel *model = [IMArrowCellModel IMCellModelWithtitle:web.title];
        [models addObject:model];
        
        }
    
    IMCellGroupModel *group = [[IMCellGroupModel alloc] init];
    group.section = models;
    [self.cells addObject:group];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *webController = [[WebViewController alloc] init];
    MainNavViewController *navController = [[MainNavViewController alloc] initWithRootViewController:webController];
    webController.web = self.webs[indexPath.row];
    [self.navigationController presentViewController:navController animated:YES completion:^{
        
    }];
}

@end
