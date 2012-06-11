//
//  NSImageCellProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSImageCellProcessor.h"

@implementation NSImageCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSImageCell";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"imageAlignment"])
	{
		aString = [self imageAlignmentString:value];
	}
	else if ([item isEqualToString:@"imageFrameStyle"])
	{
		aString = [self imageFrameStyleString:value];
	}
	else if ([item isEqualToString:@"imageScaling"])
	{
		aString = [self imageScalingString:value];
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

- (NSString *)imageAlignmentString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSImageAlignCenter",
                       @"NSImageAlignTop",
                       @"NSImageAlignTopLeft",
					   @"NSImageAlignTopRight",
					   @"NSImageAlignLeft",
					   @"NSImageAlignBottom",
					   @"NSImageAlignBottomLeft",
					   @"NSImageAlignBottomRight",
					   @"NSImageAlignRight", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

- (NSString *)imageFrameStyleString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSImageFrameNone",
                       @"NSImageFramePhoto",
                       @"NSImageFrameGrayBezel",
					   @"NSImageFrameGroove",
					   @"NSImageFrameButton", nil];
	NSUInteger index = [value unsignedIntegerValue];
	NSUInteger count = [values count];
	return (index < count) ? [values objectAtIndex:index] : nil;
}

@end
