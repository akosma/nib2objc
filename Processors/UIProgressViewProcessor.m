//
//  UIProgressViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIProgressViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIProgressViewProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIProgressView";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"progress"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"progressViewStyle"])
    {
        NSString *stringOutput = [value progressViewStyleString];
        [output setObject:stringOutput forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
