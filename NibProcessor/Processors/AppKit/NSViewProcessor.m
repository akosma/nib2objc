//
//  NSViewProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSViewProcessor.h"

@implementation NSViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSView";
}

- (NSString *)frameString
{
	NSPoint point = NSPointFromString([self.input objectForKey:@"frameOrigin"]);
	NSSize size = NSSizeFromString([self.input objectForKey:@"frameSize"]);
	return [NSString stringWithFormat:@"NSMakeRect((CGFloat)%1.1f, (CGFloat)%1.1f, (CGFloat)%1.1f, (CGFloat)%1.1f)", point.x, point.y, size.width, size.height];
}

- (NSString *)constructorString
{
	return [NSString stringWithFormat:@"[[[%@ alloc] initWithFrame:%@] autorelease]", [self getProcessedClassName], [self frameString]];
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"class"])
    {
        aString = [self getProcessedClassName];
    }
	else if ([item isEqualToString:@"autoresizesSubviews"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"autoresizingMask"])
	{
		aString = [self autoresizingMaskString:value];
	}
	else if ([item isEqualToString:@"focusRingType"])
	{
		aString = [self focusRingTypeString:value];
	}
	else if ([item isEqualToString:@"hidden"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"tag"])
	{
		aString = [NSString stringWithFormat:@"%@", value];
	}
	else if ([item isEqualToString:@"wantsLayer"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
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

- (NSString *)checkString:(NSString *)aString key:(id)item value:(id)value
{
	id object = nil;
	
	NSString *aClassName = [self getProcessedClassName];
	
	if ([aClassName hasSuffix:@"Cell"])
	{
		if ([aClassName isEqualToString:@"NSImageCell"])
		{
			Class aClass = NSClassFromString(@"NSImageView");
			
			if (aClass)
			{
				object = [[[[aClass alloc] initWithFrame:NSZeroRect] autorelease] cell];
			}
		}
		else
		{
			Class aClass = NSClassFromString([aClassName substringToIndex:[aClassName length] - [@"Cell" length]]);
			
			if (aClass)
			{
				object = [[[[aClass alloc] initWithFrame:NSZeroRect] autorelease] cell];
			}
		}
	}
	else if ([aClassName isEqualToString:@"NSArrayController"])
	{
		Class aClass = NSClassFromString(@"NSArrayController");
		
		if (aClass)
		{
			object = [[[aClass alloc] init] autorelease];
		}
	}
	else
	{
		Class aClass = NSClassFromString(aClassName);
		
		if (aClass)
		{
			object = [[[aClass alloc] initWithFrame:NSZeroRect] autorelease];
		}
	}
	
	if (object)
	{
		SEL selector = NSSelectorFromString(item);
		
		BOOL flag = [object respondsToSelector:selector];
		
		if (!flag)
		{
			selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"is", [item stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[item substringToIndex:1] uppercaseString]]]);
			flag = [object respondsToSelector:selector];
		}
		
		if (flag)
		{
			id anObject = [object valueForKey:item];
			
			if (anObject)
			{
				if (CFGetTypeID(value) == CFGetTypeID(anObject))
				{
					if (CFGetTypeID(value) == CFStringGetTypeID())
					{
						if ([value isEqualToString:anObject])
						{
#ifdef DEBUG
							aString = [NSString stringWithFormat:@"// default: %@", aString];
#else
							aString = nil;
#endif
						}
					}
					else if (value == anObject)
					{
#ifdef DEBUG
						aString = [NSString stringWithFormat:@"// default: %@", aString];
#else
						aString = nil;
#endif
					}
				}
			}
		}
	}
	
	return aString;
}

- (NSString *)autoresizingMaskString:(id)value
{
	/* From the documentation
    enum 
    {
		NSViewNotSizable = 0,
		NSViewMinXMargin = 1,
		NSViewWidthSizable = 2,
		NSViewMaxXMargin = 4,
		NSViewMinYMargin = 8,
		NSViewHeightSizable = 16,
		NSViewMaxYMargin = 32
    };
	 */
    
    NSUInteger mask = [value unsignedIntegerValue];
    NSMutableString *maskValue = [[[NSMutableString alloc] init] autorelease];
	
	if (mask == NSViewNotSizable)
	{
		[maskValue appendString:@"NSViewNotSizable"];
	}
    if ((mask & NSViewMinXMargin) == NSViewMinXMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewMinXMargin"];
    }
    if ((mask & NSViewWidthSizable) == NSViewWidthSizable)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewWidthSizable"];
    }
    if ((mask & NSViewMaxXMargin) == NSViewMaxXMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewMaxXMargin"];
    }
	if ((mask & NSViewMinYMargin) == NSViewMinYMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewMinYMargin"];
    }
	if ((mask & NSViewHeightSizable) == NSViewHeightSizable)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewHeightSizable"];
    }
	if ((mask & NSViewMaxYMargin) == NSViewMaxYMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSViewMaxYMargin"];
    }
    
    return maskValue;
}

- (NSString *)borderTypeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSNoBorder",
                       @"NSLineBorder",
                       @"NSBezelBorder",
					   @"NSGrooveBorder", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)colorString:(id)value
{
    NSMutableString *color = [[[NSMutableString alloc] init] autorelease];
    if ([value hasPrefix:@"NSCalibratedRGBColorSpace"])
    {
        float red, green, blue, alpha;
        sscanf([value UTF8String], "NSCalibratedRGBColorSpace %f %f %f %f", &red, &green, &blue, &alpha);
        [color appendFormat:@"[NSColor colorWithCalibratedRed:(CGFloat)%f green:(CGFloat)%f blue:(CGFloat)%f alpha:(CGFloat)%1.1f]", red, green, blue, alpha];
    }
    else if ([value hasPrefix:@"NSCalibratedWhiteColorSpace"])
    {
        float white, alpha;
        sscanf([value UTF8String], "NSCalibratedWhiteColorSpace %f %f", &white, &alpha);
        [color appendFormat:@"[NSColor colorWithCalibratedWhite:(CGFloat)%f alpha:(CGFloat)%1.1f]", white, alpha];
    }
	else if ([value hasPrefix:@"NSDeviceRGBColorSpace"])
    {
        float red, green, blue, alpha;
        sscanf([value UTF8String], "NSDeviceRGBColorSpace %f %f %f %f", &red, &green, &blue, &alpha);
        [color appendFormat:@"[NSColor colorWithDeviceRed:(CGFloat)%f green:(CGFloat)%f blue:(CGFloat)%f alpha:(CGFloat)%1.1f]", red, green, blue, alpha];
    }
	else if ([value hasPrefix:@"NSNamedColorSpace"])
    {
		char listName[256], colorName[256];
		sscanf([value UTF8String], "NSNamedColorSpace %s %s", &listName, &colorName);
		[color appendFormat:@"[NSColor colorWithCatalogName:@\"%@\" colorName:@\"%@\"]", [NSString stringWithUTF8String:listName], [NSString stringWithUTF8String:colorName]];
	}
	else
    {
        [color appendString:value];
    }
    return color;
}

- (NSString *)floatString:(id)value
{
    return [NSString stringWithFormat:@"(CGFloat)%1.1f", [value floatValue]];
}

- (NSString *)focusRingTypeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSFocusRingTypeDefault",
                       @"NSFocusRingTypeNone",
                       @"NSFocusRingTypeExterior", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)fontString:(id)value
{
	NSString *fontName = [value objectForKey:@"Name"];
	float fontSize = [[value objectForKey:@"Size"] floatValue];
	return [NSString stringWithFormat:@"[NSFont fontWithName:@\"%@\" size:(CGFloat)%1.1f]", fontName, fontSize];
}

- (NSString *)sizeString:(id)value
{
	NSSize size = NSSizeFromString(value);
	return [NSString stringWithFormat:@"NSMakeSize((CGFloat)%1.1f, (CGFloat)%1.1f)", size.width, size.height];
}

@end
