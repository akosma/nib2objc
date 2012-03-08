//
//  NSSearchFieldCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSSearchFieldCellProcessor.h"

@implementation NSSearchFieldCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSSearchFieldCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"maximumRecents"])
	{
		aString = [NSString stringWithFormat:@"%@", value];
	}
	else if ([item isEqualToString:@"sendsSearchStringImmediately"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"sendsWholeSearchString"])
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

@end
