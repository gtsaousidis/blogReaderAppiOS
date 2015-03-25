//
//  TableViewController.h
//  BlogReader
//
//  Created by George Tsaousidis on 19/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface TableViewController : UITableViewController

@property (strong , nonatomic) NSMutableArray *blogPosts;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property(strong, nonatomic) Reachability *internetReachableFoo;

@end
