//
//  WebViewController.m
//  IMLottery
//
//  Created by feng-Mac on 16/8/22.
//  Copyright © 2016年 feng-Mac. All rights reserved.
//

#import "WebViewController.h"
#import "IMWebModel.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)loadView{
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置控制器左端的返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    //根据文件地址在控制器中加载网页
    UIWebView *webView = (UIWebView *)self.view;
    //设置成为webview的代理
    webView.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.web.html withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //格式window.location.href = '#howtorecharge'
    NSString *str = [NSString stringWithFormat:@"window.location.href = '#%@'",self.web.ID];
    [webView stringByEvaluatingJavaScriptFromString:str];
    
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
