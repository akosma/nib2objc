//
//  NSCollectionViewProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSCollectionViewProcessor.h"

@implementation NSCollectionViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSCollectionView";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
    if ([item isEqualToString:@"allowsMultipleSelection"])
    {
        aString = ([value boolValue]) ? @"YES" : @"NO";
    }
    else if ([item isEqualToString:@"maxNumberOfColumns"])
    {
        aString = [NSString stringWithFormat:@"%@", value];
    }
	else if ([item isEqualToString:@"maxNumberOfRows"])
    {
        aString = [NSString stringWithFormat:@"%@", value];
    }
	else if ([item isEqualToString:@"hasSecondaryBackgroundColor"])
    {
		if ([value boolValue])
		{
			aString = [self colorString:value];
			item = @"backgroundColors";
		}
    }
	else if ([item isEqualToString:@"selectable"])
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

- (NSString *)colorString:(id)value
{
	NSString *aString = nil;
	NSString *primaryBackgroundColor = [super colorString:[self.input objectForKey:@"primaryBackgroundColor"]];
	NSString *secondaryBackgroundColor = [super colorString:[self.input objectForKey:@"secondaryBackgroundColor"]];
	aString = [NSString stringWithFormat:@"[NSArray arrayWithObjects:%@, %@, nil]", primaryBackgroundColor, secondaryBackgroundColor];
	return aString;
}

@end
