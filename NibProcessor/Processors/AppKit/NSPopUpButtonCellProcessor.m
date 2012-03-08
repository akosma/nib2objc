//
//  NSPopUpButtonCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSPopUpButtonCellProcessor.h"

@implementation NSPopUpButtonCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSPopUpButtonCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"arrowPosition"])
	{
		aString = [self arrowPositionString:value];
	}
	else if ([item isEqualToString:@"preferredEdge"])
	{
		aString = [self preferredEdgeString:value];
	}
	else if ([item isEqualToString:@"pullsDown"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
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
	NSArray *values = [NSArray arrayWithObjects:@"NSPopUpNoArrow",
                       @"NSPopUpArrowAtCenter",
                       @"NSPopUpArrowAtBottom", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)preferredEdgeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSMinXEdge",
                       @"NSMinYEdge",
                       @"NSMaxXEdge",
					   @"NSMaxYEdge", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

@end
