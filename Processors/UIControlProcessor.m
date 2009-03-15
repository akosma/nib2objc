//
//  UIControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIControlProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIControlProcessor

- (void)dealloc
{
    [super dealloc];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"contentHorizontalAlignment"])
    {
        NSString *stringOutput = [value contentHorizontalAlignmentString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"contentVerticalAlignment"])
    {
        NSString *stringOutput = [value contentVerticalAlignmentString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"highlighted"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"selected"])
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
