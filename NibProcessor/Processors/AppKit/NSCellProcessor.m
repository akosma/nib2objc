//
//  NSCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSCellProcessor.h"

@implementation NSCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"class"])
    {
        aString = [self getProcessedClassName];
    }
	else if ([item isEqualToString:@"alignment"])
	{
		aString = [self alignmentString:value];
	}
	else if ([item isEqualToString:@"animates"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"baseWritingDirection"])
	{
		aString = [self baseWritingDirectionString:value];
	}
	else if ([item isEqualToString:@"bordered"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"continuous"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"controlSize"])
	{
		aString = [self controlSizeString:value];
	}
	else if ([item isEqualToString:@"editable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"enabled"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"lineBreakMode"])
	{
		aString = [self lineBreakModeString:value];
	}
	else if ([item isEqualToString:@"scrollable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"selectable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"sendsActionOnEndEditing"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"state"])
	{
		aString = [self stateString:value];
	}
	else if ([item isEqualToString:@"title"])
	{
		aString = [NSString stringWithFormat:@"@\"%@\"", value];
	}
	else if ([item isEqualToString:@"truncatesLastVisibleLine"])
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

- (NSString *)alignmentString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSLeftTextAlignment",
                       @"NSRightTextAlignment",
                       @"NSCenterTextAlignment",
					   @"NSJustifiedTextAlignment",
					   @"NSNaturalTextAlignment", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)baseWritingDirectionString:(id)value
{
	/* From the documentation
	 enum 
	 {
	 NSWritingDirectionNatural = -1,
	 NSWritingDirectionLeftToRight = 0,
	 NSWritingDirectionRightToLeft = 1
	 };
	 */
	
	NSString *aString = nil;
	NSInteger integerValue = [value integerValue];
	if (integerValue == NSWritingDirectionNatural)
    {
        aString = @"NSWritingDirectionNatural";
    }
    else if (integerValue == NSWritingDirectionLeftToRight)
    {
        aString = @"NSWritingDirectionLeftToRight";
    }
    else if (integerValue == NSWritingDirectionRightToLeft)
    {
		aString = @"NSWritingDirectionRightToLeft";
    }
	return aString;
}

- (NSString *)controlSizeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSRegularControlSize",
                       @"NSSmallControlSize",
                       @"NSMiniControlSize", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)imageScalingString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSImageScaleProportionallyDown",
                       @"NSImageScaleAxesIndependently",
                       @"NSImageScaleNone",
					   @"NSImageScaleProportionallyUpOrDown", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)lineBreakModeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSLineBreakByWordWrapping",
                       @"NSLineBreakByCharWrapping",
                       @"NSLineBreakByClipping",
					   @"NSLineBreakByTruncatingHead",
					   @"NSLineBreakByTruncatingTail",
					   @"NSLineBreakByTruncatingMiddle", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)stateString:(id)value
{
	/* From the documentation
	 enum {
	 NSMixedState = -1,
	 NSOffState = 0,
	 NSOnState = 1    
	 };
	 */
	
	NSString *aString = nil;
	NSInteger integerValue = [value integerValue];
	if (integerValue == NSMixedState)
    {
        aString = @"NSMixedState";
    }
    else if (integerValue == NSOffState)
    {
        aString = @"NSOffState";
    }
    else if (integerValue == NSOnState)
    {
		aString = @"NSOnState";
    }
	return aString;
}

@end
