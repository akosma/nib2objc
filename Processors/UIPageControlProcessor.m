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

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIPageControl";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"currentPage"])
    {
        NSString *stringOutput = [value intString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"numberOfPages"])
    {
        NSString *stringOutput = [value intString];
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
