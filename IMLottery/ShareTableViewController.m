//
//  ShareTableViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/21.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "ShareTableViewController.h"
#import "IMArrowCellModel.h"
#import "IMCellGroupModel.h"
#import <MessageUI/MessageUI.h>

@interface ShareTableViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation ShareTableViewController

- (void)settingCellsData{
    
    IMArrowCellModel *model00 = [IMArrowCellModel IMArrowCellModelWithtitle:@"新浪微博"  destVcClass:nil];
    IMArrowCellModel *model01 = [IMArrowCellModel IMArrowCellModelWithtitle:@"短信分享"  destVcClass:nil];
    model01.imBlock = ^(){
//        发短信，方法一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10010"]];
        
//        //发短信，方法二
//        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//        controller.body = @"zhang";
//        controller.recipients = @[@"10086"];
//        controller.messageComposeDelegate = self;
//        [self presentViewController:controller animated:YES completion:nil];
        
        
    };
    IMArrowCellModel *model02 = [IMArrowCellModel IMArrowCellModelWithtitle:@"邮件分享"  destVcClass:nil];
    
    model02.imBlock = ^(){
        //方法一直接发送邮件
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://13918667287@163.com"]];
        //方法二
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setSubject:@"meeting"];
        [controller setMessageBody:@"zhang" isHTML:NO];
        //收件人列表
        [controller setToRecipients:@[@"13918667287@163.com"]];
        //抄送人列表
        [controller setCcRecipients:@[@"130851980$@qq.com"]];
        //密送人列表
        [controller setBccRecipients:@[@"2966341443@qq.com"]];
        controller.mailComposeDelegate = self;
        //设置附件
//        [controller addAttachmentData:<#(nonnull NSData *)#> mimeType:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#>]
        [self presentViewController:controller animated:YES completion:nil];

    };
    
    __weak typeof(self) selfVc = self;
    IMCellGroupModel *group01 = [[IMCellGroupModel alloc] init];
    group01.section = @[model00,model01,model02];
    [selfVc.cells addObject:group01];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultSent) {
        NSLog(@"信息发送成功");
    }else if (result == MessageComposeResultFailed){
        NSLog(@"信息发送失败");
    }else if(result == MessageComposeResultCancelled){
        NSLog(@"信息取消发送");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingCellsData];
    //
    //    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
}


@end
