//
//  WebViewController.m
//  BlogReader
//
//  Created by George Tsaousidis on 22/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *url = [NSURL URLWithString:@"http://blog.teamtreehouse.com"];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.blogPostUrl];
    
    [self.webView loadRequest:urlRequest];
    
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
