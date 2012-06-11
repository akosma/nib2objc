//
//  NSScrollViewProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSScrollViewProcessor.h"

@implementation NSScrollViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSScrollView";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
    if ([item isEqualToString:@"autohidesScrollers"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"backgroundColor"])
    {
        aString = [self colorString:value];
    }
    else if ([item isEqualToString:@"borderType"])
    {
        aString = [self borderTypeString:value];
    }
	else if ([item isEqualToString:@"contentView.copiesOnScroll"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"drawsBackground"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"hasHorizontalRuler"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"hasHorizontalScroller"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"hasVerticalRuler"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"hasVerticalScroller"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"horizontalLineScroll"])
    {
        aString = [self floatString:value];
    }
	else if ([item isEqualToString:@"horizontalPageScroll"])
    {
        aString = [self floatString:value];
    }
	else if ([item isEqualToString:@"verticalLineScroll"])
    {
        aString = [self floatString:value];
    }
	else if ([item isEqualToString:@"verticalPageScroll"])
    {
        aString = [self floatString:value];
    }
    else
    {
        [super processKey:item value:value];
    }
	if (aString != nil)
    {
        aString = [self checkString:aString key:item value:value];
    }
	if (aString != nil)
    {
        [output setObject:aString forKey:item];
    }
}

@end
