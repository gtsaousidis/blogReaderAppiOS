//
//  TableViewController.m
//  BlogReader
//
//  Created by George Tsaousidis on 19/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"
#import "WebImageOperation.h"
#import "Reachability.h"

@interface TableViewController ()

@end

@implementation TableViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    [self.indicator startAnimating];
    
    
    [self chechingForInternet];
    
}

-(void)loadData{
    
    
    // Setting the url we want to take the json data
    NSURL *blogUrl = [NSURL URLWithString:@"http://www.dfg-team.com/api/get_recent_posts"];
    
    // Request for async task
    NSURLRequest *request = [NSURLRequest requestWithURL:blogUrl];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self getReceiveData:data];
        
        
    }];

}

// Checks if we have an internet connection or not
- (void)testInternetConnection
{
    
}




-(void)chechingForInternet
{
    
    __weak typeof(self) weakSelf = self;
    
// Internet is reachable
self.internetReachableFoo.reachableBlock = ^(Reachability*reach)
{
    // Update the UI on the main thread
    
    [weakSelf loadData];
    
    [weakSelf startTheRefresh];
    
};

// Internet is not reachable
self.internetReachableFoo.unreachableBlock = ^(Reachability*reach)
{
    // Update the UI on the main thread
    NSString *messageX =   [NSString stringWithFormat: @"There is no internet connection \n"];
    
    
    UIAlertView *alertForInternetConnection = [[UIAlertView alloc]initWithTitle:nil
                                                                        message:messageX
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Cancel"
                                                              otherButtonTitles:nil];
    
    [alertForInternetConnection show];
    
    
};

[self.internetReachableFoo startNotifier];
}




////////////////////////////////////////////////////////////////
/////////////////////////GET THE DATA///////////////////////////
////////////////////////////////////////////////////////////////

-(void)getReceiveData:(NSData *)jsondata{
    
    
    NSError *error = nil;
    
    //Converting the data for NSDictionary objects can understand them
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:&error];
    
    //initialize the nsmutablearray as array because we don't know the capasity,
    self.blogPosts = [NSMutableArray array];
    
    //storing the data from dataDictionary to a NSArray
    NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    
    //loop throught the blogPostsArray to storing the data and populate the nsmutablearray blogPosts
    
    for (NSDictionary *bpDictionary in blogPostsArray) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
        blogPost.date   = [bpDictionary objectForKey:@"date"];
        blogPost.author = [bpDictionary valueForKeyPath:@"author.name"];
        blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
    }
    
    
    [self.tableView reloadData];
    [self.indicator stopAnimating];

}


////////////////////////////////////////////////////////////////
///////////////////////END GET THE DATA/////////////////////////
////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////
///////////////////////REFRESH THE DATA/////////////////////////
////////////////////////////////////////////////////////////////


-(void)startTheRefresh{

    //Initialise the refresh controller
    self.refreshControl = [[UIRefreshControl alloc] init];
    //Set the title for pull request
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to Refresh"];
    //Call he refresh function
    [self.refreshControl addTarget:self action:@selector(refreshMyTableView)forControlEvents:UIControlEventValueChanged];

}



-(void)refreshMyTableView{
    
    //set the title while refreshing
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing the TableView"];
    
    
    [self chechingForInternet];
    
    //set the date and time of refreshing
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    [formattedDate setDateFormat:@"MMM d, h:mm a"];
    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
    
    //end the refreshing
    [self.refreshControl endRefreshing];
    
}
////////////////////////////////////////////////////////////////
/////////////////////END REFRESH THE DATA///////////////////////
////////////////////////////////////////////////////////////////




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    BlogPost *blogPost =[self.blogPosts objectAtIndex:indexPath.row];
    
    
    //Cheking if there is an image or not
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        
        //Downloading the image
        [WebImageOperation loadFromURL:blogPost.thumbnailUrl callback:^(UIImage *image) {
            cell.imageView.image = image;
            [cell setNeedsLayout];
            
        }];
        
        
//        NSData *imageData = [NSData dataWithContentsOfURL:blogPost.thumbnailUrl];
//        UIImage *image = [UIImage imageWithData:imageData];
        
        
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ | Date: %@",blogPost.author, blogPost.formattedDate];
    cell.textLabel.text = blogPost.title;
    
    
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
        WebViewController *wbc = (WebViewController *)segue.destinationViewController;
        wbc.blogPostUrl = blogPost.url;
        
        
    }
}

@end
