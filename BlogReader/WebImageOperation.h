//
//  WebImageOperation.h
//  BlogReader
//
//  Created by George Tsaousidis on 24/3/15.
//  Copyright (c) 2015 DFG-Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebImageOperation : NSObject


// This takes in a string and imagedata object and returns imagedata processed on a background thread
+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback;


@end
