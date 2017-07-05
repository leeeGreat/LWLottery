//
//  BaseTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "BaseTableViewController.h"
#import "IMTableViewCell.h"
#import "IMCellGroupModel.h"
#import "IMArrowCellModel.h"
#import "IMSwitchCellModel.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

-  (NSMutableArray *)cells{
   if (_cells == nil) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source，实现数据源方法

//实现tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IMCellGroupModel *group = self.cells[section];
    return group.section.count;
}


//实现tableView代理方法
//注意：如果同时实现header的title方法和view方法，两个方法在加载的时候会同时调用，先调用title方法，在调用view方法，如果view方法中返回的UIView有值，会直接覆盖title方法，如果UIView为空，则返回title方法中的字符串
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    IMCellGroupModel *group= self.cells[section];
    return group.header;
}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    IMCellGroupModel *group= self.cells[section];
//    return group.headerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[IMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    IMCellGroupModel *group= self.cells[indexPath.section];
    cell.model = group.section[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    IMCellGroupModel *group= self.cells[section];
    return group.footer;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IMCellGroupModel *group= self.cells[indexPath.section];
    IMCellModel *cell = group.section[indexPath.row];
    
    if (cell.imBlock){
        cell.imBlock();
    }
    
    if ([cell isKindOfClass:[IMArrowCellModel class]]) {
        IMArrowCellModel *ArrowCell = (IMArrowCellModel *)cell;//如果这里不强转的话下面一句会报错，因为只有在运行时才会检测真值类型
        if (ArrowCell.destVcClass == nil) return;//如果没有设定目标控制器则不进行任何操作
        UIViewController *controller = [[ArrowCell.destVcClass alloc] init];
        controller.title = cell.title;
        [self.navigationController pushViewController:controller animated:YES];
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of a.0ny resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
