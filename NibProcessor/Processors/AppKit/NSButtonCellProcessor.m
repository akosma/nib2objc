//
//  NSButtonCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSButtonCellProcessor.h"

@implementation NSButtonCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSButtonCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"allowsMixedState"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
	else if ([item isEqualToString:@"alternateTitle"])
    {
        aString = [NSString stringWithFormat:@"@\"%@\"", value];
    }
	else if ([item isEqualToString:@"bezelStyle"])
    {
        aString = [self bezelStyleString:value];
    }
	else if ([item isEqualToString:@"font"])
    {
        aString = [self fontString:value];
    }
	else if ([item isEqualToString:@"gButtonBehavior"])
	{
		int intValue = [value intValue];
		if (intValue == 6)
		{
			value = [NSNumber numberWithUnsignedInteger:0];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 7)
		{
			value = [NSNumber numberWithUnsignedInteger:7];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 30)
		{
			value = [NSNumber numberWithUnsignedInteger:6];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 31)
		{
			value = [NSNumber numberWithUnsignedInteger:1];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 128)
		{
			value = [NSNumber numberWithUnsignedInteger:5];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 161)
		{
			value = [NSNumber numberWithUnsignedInteger:2];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
		else if (intValue == 224)
		{
			value = [NSNumber numberWithUnsignedInteger:3];
			aString = [self buttonTypeString:value];
			item = @"buttonType";
		}
	}
	else if ([item isEqualToString:@"ibImagePosition"])
    {
        aString = [self imagePositionString:value];
		item = @"imagePosition";
    }
	else if ([item isEqualToString:@"imageScaling"])
    {
        aString = [self imageScalingString:value];
    }
	else if ([item isEqualToString:@"keyEquivalentModifierMask"])
    {
        aString = [self keyEquivalentModifierMaskString:value];
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

- (NSString *)bezelStyleString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSSmallIconButtonBezelStyle",
					   @"NSRoundedBezelStyle",
                       @"NSRegularSquareBezelStyle",
                       @"NSThickSquareBezelStyle",
					   @"NSThickerSquareBezelStyle",
					   @"NSDisclosureBezelStyle",
					   @"NSShadowlessSquareBezelStyle",
					   @"NSCircularBezelStyle",
					   @"NSTexturedSquareBezelStyle",
					   @"NSHelpButtonBezelStyle",
					   @"NSSmallSquareBezelStyle",
					   @"NSTexturedRoundedBezelStyle",
					   @"NSRoundRectBezelStyle",
					   @"NSRecessedBezelStyle",
					   @"NSRoundedDisclosureBezelStyle", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)buttonTypeString:(id)value
{
	/* From the documentation
	 enum {
	 NSMomentaryLightButton = 0,
	 NSPushOnPushOffButton = 1,
	 NSToggleButton = 2,
	 NSSwitchButton = 3,
	 NSMomentaryChangeButton = 5,
	 NSOnOffButton = 6,
	 NSMomentaryPushInButton = 7
	 };
	 */
	
	NSString *aString = nil;
	NSUInteger unsignedIntegerValue = [value unsignedIntegerValue];
	if (unsignedIntegerValue == NSMomentaryLightButton)
    {
        aString = @"NSMomentaryLightButton";
    }
    else if (unsignedIntegerValue == NSMomentaryPushInButton)
    {
        aString = @"NSMomentaryPushInButton";
    }
    else if (unsignedIntegerValue == NSOnOffButton)
    {
		aString = @"NSOnOffButton";
    }
	else if (unsignedIntegerValue == NSPushOnPushOffButton)
    {
		[output setObject:@"YES" forKey:@"showsBorderOnlyWhileMouseInside"];
		aString = @"NSPushOnPushOffButton";
    }
	else if (unsignedIntegerValue == NSMomentaryChangeButton)
    {
		aString = @"NSMomentaryChangeButton";
    }
	else if (unsignedIntegerValue == NSToggleButton)
    {
		aString = @"NSToggleButton";
    }
	else if (unsignedIntegerValue == NSSwitchButton)
    {
		aString = @"NSSwitchButton";
    }
	return aString;
}

- (NSString *)imagePositionString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSNoImage",
                       @"NSImageOnly",
                       @"NSImageLeft",
					   @"NSImageRight",
					   @"NSImageBelow",
					   @"NSImageAbove",
					   @"NSImageOverlaps", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)keyEquivalentModifierMaskString:(id)value
{
    /* From the documentation
	 enum 
	 {
	 NSAlphaShiftKeyMask = 1 << 16,
	 NSShiftKeyMask = 1 << 17,
	 NSControlKeyMask = 1 << 18,
	 NSAlternateKeyMask = 1 << 19,
	 NSCommandKeyMask = 1 << 20,
	 NSNumericPadKeyMask = 1 << 21,
	 NSHelpKeyMask = 1 << 22,
	 NSFunctionKeyMask = 1 << 23
	 };
	 */
    
    NSUInteger mask = [value unsignedIntegerValue];
    NSMutableString *maskValue = [[[NSMutableString alloc] init] autorelease];
    
    if ((mask & NSAlphaShiftKeyMask) == NSAlphaShiftKeyMask)
    {
        [maskValue appendString:@"NSAlphaShiftKeyMask"];
    }
    if ((mask & NSShiftKeyMask) == NSShiftKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSShiftKeyMask"];
    }
    if ((mask & NSControlKeyMask) == NSControlKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSControlKeyMask"];
    }
    if ((mask & NSAlternateKeyMask) == NSAlternateKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSAlternateKeyMask"];
    }
	if ((mask & NSCommandKeyMask) == NSCommandKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSCommandKeyMask"];
    }
	if ((mask & NSNumericPadKeyMask) == NSNumericPadKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSNumericPadKeyMask"];
    }
	if ((mask & NSHelpKeyMask) == NSHelpKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSHelpKeyMask"];
    }
	if ((mask & NSFunctionKeyMask) == NSFunctionKeyMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSFunctionKeyMask"];
    }
	if ([maskValue length] == 0) [maskValue appendString:@"0"];
    
    return maskValue;
}

@end
