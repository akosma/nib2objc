//
//  UIPanGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIPanGestureRecognizerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIPanGestureRecognizerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIPanGestureRecognizer";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"minimumNumberOfTouches"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
