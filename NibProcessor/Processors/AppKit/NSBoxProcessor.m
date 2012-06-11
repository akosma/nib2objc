//
//  NSBoxProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSBoxProcessor.h"

@implementation NSBoxProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSBox";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"borderColor"])
	{
		aString = [self colorString:value];
	}
	else if ([item isEqualToString:@"borderType"])
    {
        aString = [self borderTypeString:value];
    }
    else if ([item isEqualToString:@"borderWidth"])
    {
        aString = [self floatString:value];
    }
	else if ([item isEqualToString:@"boxType"])
    {
		aString = [self boxTypeString:value];
    }
	else if ([item isEqualToString:@"contentViewMargins"])
    {
        aString = [self sizeString:value];
    }
	else if ([item isEqualToString:@"cornerRadius"])
    {
        aString = [self floatString:value];
    }
	else if ([item isEqualToString:@"fillColor"])
    {
        aString = [self colorString:value];
    }
	else if ([item isEqualToString:@"title"])
    {
        aString = [NSString stringWithFormat:@"@\"%@\"", value];
	}
	else if ([item isEqualToString:@"titleFont"])
    {
		aString = [self fontString:value];
	}
	else if ([item isEqualToString:@"titlePosition"])
    {
		aString = [self titlePositionString:value];
    }
	else if ([item isEqualToString:@"transparent"])
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

- (NSString *)boxTypeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSBoxPrimary",
                       @"NSBoxSecondary",
                       @"NSBoxSeparator",
					   @"NSBoxOldStyle",
					   @"NSBoxCustom", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)titlePositionString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSNoTitle",
					   @"NSAboveTop",
					   @"NSAtTop",
					   @"NSBelowTop",
					   @"NSAboveBottom",
					   @"NSAtBottom",
					   @"NSBelowBottom", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

@end
