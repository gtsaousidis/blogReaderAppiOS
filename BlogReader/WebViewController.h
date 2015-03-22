//
//  WebViewController.h
//  BlogReader
//
//  Created by George Tsaousidis on 22/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong,nonatomic) NSURL *blogPostUrl;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
