//
//  UIControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIControlProcessor.h"

@implementation UIControlProcessor

- (void)processUnknownProperty:(id)item value:(id)value
{
    [super processUnknownProperty:item value:value];
    if ([item isEqualToString:@"contentHorizontalAlignment"])
    {
        [output appendFormat:@"%@.contentHorizontalAlignment = %@;\n", instanceName, [self contentHorizontalAlignmentForValue:value]];
    }
    else if ([item isEqualToString:@"contentVerticalAlignment"])
    {
        [output appendFormat:@"%@.contentVerticalAlignment = %@;\n", instanceName, [self contentVerticalAlignmentForValue:value]];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        [output appendFormat:@"%@.enabled = %@\n", instanceName, [self booleanFromValue:value]];
    }
    else if ([item isEqualToString:@"highlighted"])
    {
        [output appendFormat:@"%@.highlighted = %@\n", instanceName, [self booleanFromValue:value]];
    }
    else if ([item isEqualToString:@"selected"])
    {
        [output appendFormat:@"%@.selected = %@\n", instanceName, [self booleanFromValue:value]];
    }
}

@end
