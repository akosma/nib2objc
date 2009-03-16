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

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIProgressView";
}

- (NSString *)constructorString
{
    NSString *style = [[self.input objectForKey:@"progressViewStyle"] progressViewStyleString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithProgressViewStyle:%@]", [self getProcessedClassName], style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"progress"])
    {
        NSString *stringOutput = [value floatString];
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
