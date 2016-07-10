//
//  ZZYCustomViewController.m
//  ZZYMenuController
//
//  Created by admin on 16/7/9.
//  Copyright © 2016年 断剑. All rights reserved.
//

#import "ZZYCustomViewController.h"
#import "ZZYMenuLabel.h"

@interface ZZYCustomViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet ZZYMenuLabel *label;
@end

@implementation ZZYCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadHTMLString:@"<div style=\"color:red;\">这是一个WebView控件</div>" baseURL:nil];

    
    self.label.text = @"这是一个Label控件";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
