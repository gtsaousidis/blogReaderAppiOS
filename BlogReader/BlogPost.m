//
//  BlogPost.m
//  BlogReader
//
//  Created by George Tsaousidis on 21/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost


-(id) initWithTitle:(NSString *)title;{

    self = [super init];
    if (self) {
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    return self;
};

+(id) blogPostWithTitle:(NSString *)title{
    return [[self alloc]initWithTitle:title];
};

-(NSURL *) thumbnailUrl{
    return [NSURL URLWithString:self.thumbnail];
};

//Changing format in our date
-(NSString *) formattedDate{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"el_GR"];
    [dateFormatter setLocale:locale];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    return [dateFormatter stringFromDate:tempDate];
    
    
};


@end
