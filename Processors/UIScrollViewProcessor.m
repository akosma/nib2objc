//
//  UIScrollViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIScrollViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIScrollViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIScrollView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"indicatorStyle"])
    {
        NSString *stringOutput = [value scrollViewIndicatorStyleString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"showsHorizontalScrollIndicator"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"showsVerticalScrollIndicator"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"scrollEnabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"pagingEnabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"directionalLockEnabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"bounces"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"alwaysBounceHorizontal"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"alwaysBounceVertical"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"maximumZoomScale"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"minimumZoomScale"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"bouncesZoom"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"delaysContentTouches"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"canCancelContentTouches"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
