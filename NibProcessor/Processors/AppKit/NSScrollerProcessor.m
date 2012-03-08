//
//  NSScrollerProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSScrollerProcessor.h"

@implementation NSScrollerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSScroller";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
    if ([item isEqualToString:@"arrowsPosition"])
    {
		aString = [self arrowPositionString:value];
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

- (NSString *)arrowPositionString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSScrollerArrowsDefaultSetting",
					   @"NSScrollerArrowsMinEnd",
					   @"NSScrollerArrowsNone", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

@end
