//
//  WebImageOperation.m
//  BlogReader
//
//  Created by George Tsaousidis on 24/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import "WebImageOperation.h"

@implementation WebImageOperation

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}




@end
