//
//  LocalHtmlVC.m
//  IMLottery
//
//  Created by qianbaoeo on 2017/7/10.
//  Copyright © 2017年 feng-Mac. All rights reserved.
//

#import "LocalHtmlVC.h"

@interface LocalHtmlVC ()

@end

@implementation LocalHtmlVC
{
    UIWebView *web;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.urlStr withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIWebView class]]) {
            web = (UIWebView *)subView;
        }
    }
    [web loadRequest:request];
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

@end
