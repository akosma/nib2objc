//
//  NSTextFieldCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSTextFieldCellProcessor.h"

@implementation NSTextFieldCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSTextFieldCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"allowsEditingTextAttributes"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"backgroundColor"])
	{
		aString = [self colorString:value];
	}
	else if ([item isEqualToString:@"drawsBackground"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"font"])
	{
		aString = [self fontString:value];
	}
	else if ([item isEqualToString:@"gBorderType"])
	{
		int intValue = [value intValue];
		if (intValue == 0)
		{
			aString = @"NO";
			item = @"bezeled";
		}
		else if (intValue == 2)
		{
			value = [NSNumber numberWithUnsignedInteger:0];
			aString = [self bezelStyleString:value];
			item = @"bezelStyle";
		}
		else if (intValue == 3)
		{
			value = [NSNumber numberWithUnsignedInteger:1];
			aString = [self bezelStyleString:value];
			item = @"bezelStyle";
		}
	}
	else if ([item isEqualToString:@"textColor"])
	{
		aString = [self colorString:value];
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

- (NSString *)bezelStyleString:(id)value
{
	/* From the documentation
	enum {
		NSTextFieldSquareBezel = 0,
		NSTextFieldRoundedBezel = 1
	};
	 */
	
	NSString *aString = nil;
	NSUInteger unsignedIntegerValue = [value unsignedIntegerValue];
	if (unsignedIntegerValue == NSTextFieldSquareBezel)
	{
		aString = @"NSTextFieldSquareBezel";
	}
	else if (unsignedIntegerValue == NSTextFieldRoundedBezel)
	{
		aString = @"NSTextFieldRoundedBezel";
	}
	return aString;
}

@end
