//
//  UISwipeGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UISwipeGestureRecognizerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISwipeGestureRecognizerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISwipeGestureRecognizer";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"numberOfTouchesRequired"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"direction"])
    {
        [output setObject:[value swipeGestureRecognizerDirectionString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
