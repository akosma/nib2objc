//
//  UIPageControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIPageControlProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIPageControlProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIPageControl";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"currentPage"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%d", [value intValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"numberOfPages"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%d", [value intValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"hidesForSinglePage"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"defersCurrentPageDisplay"])
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
