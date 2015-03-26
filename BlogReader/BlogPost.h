//
//  BlogPost.h
//  BlogReader
//
//  Created by George Tsaousidis on 21/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *thumbnail;
@property   (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSURL *url;


-(id) initWithTitle:(NSString *)title;
+(id) blogPostWithTitle:(NSString *)title;

-(NSURL *) thumbnailUrl;
-(NSString *) formattedDate;

@end
