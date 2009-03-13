//
//  UIViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIViewProcessor.h"

@implementation UIViewProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIView";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)process:(NSDictionary *)dict into:(NSMutableString *)output
{
    [output appendFormat:@"%@ *instance = [[%@ alloc] init];\n", klass, klass];
    for (id item in dict)
    {
        id value = [dict objectForKey:item];
        if ([value isKindOfClass:[NSNumber class]])
        {
            [output appendFormat:@"instance.%@ = %@;\n", item, value];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            [output appendFormat:@"instance.%@ = @\"%@\";\n", item, value];
        }
    }
}

@end
