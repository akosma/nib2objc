//
//  UIActivityIndicatorViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIActivityIndicatorViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIActivityIndicatorViewProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIActivityIndicatorView";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)constructorString
{
    NSString *style = [[input objectForKey:@"style"] activityIndicatorViewStyleString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithActivityIndicatorStyle:%@]", klass, style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"style"])
    {
        NSString *stringOutput = [value activityIndicatorViewStyleString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"hidesWhenStopped"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"animating"])
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
