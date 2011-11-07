//
//  UIPinchGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIPinchGestureRecognizerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIPinchGestureRecognizerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIPinchGestureRecognizer";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"scale"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
