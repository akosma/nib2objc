//
//  NSArrayControllerProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSArrayControllerProcessor.h"

@implementation NSArrayControllerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSArrayController";
}

- (NSString *)constructorString
{
	NSString *className = [self getProcessedClassName];
	return [NSString stringWithFormat:@"[[[%@ alloc] init] autorelease]", className];
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"alwaysUsesMultipleValuesMarkerDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"alwaysUsesMultipleValuesMarker";
	}
	else if ([item isEqualToString:@"automaticallyPreparesContentDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"automaticallyPreparesContent";
	}
	else if ([item isEqualToString:@"automaticallyRearrangesObjectsDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"automaticallyRearrangesObjects";
	}
	else if ([item isEqualToString:@"avoidsEmptySelectionDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"avoidsEmptySelection";
	}
	else if ([item isEqualToString:@"clearsFilterPredicateOnInsertionDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"clearsFilterPredicateOnInsertion";
	}
	else if ([item isEqualToString:@"editableDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"editable";
	}
	else if ([item isEqualToString:@"objectClassNameDesignable"])
	{
		aString = [NSString stringWithFormat:@"NSClassFromString(@\"%@\")", value];
		item = @"objectClass";
	}
	else if ([item isEqualToString:@"preservesSelectionDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"preservesSelection";
	}
	else if ([item isEqualToString:@"selectsInsertedObjectsDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"selectsInsertedObjects";
	}
	else if ([item isEqualToString:@"usesLazyFetchingDesignable"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
		item = @"usesLazyFetching";
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
