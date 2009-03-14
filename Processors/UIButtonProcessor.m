//
//  UIButtonProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIButtonProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIButtonProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIButton";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)constructorString
{
    NSString *style = [[input objectForKey:@"buttonType"] buttonTypeString];
    return [NSString stringWithFormat:@"[%@ buttonWithType:%@]", klass, style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"buttonType"])
    {
        NSString *stringOutput = [value buttonTypeString];
        [output setObject:stringOutput forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
