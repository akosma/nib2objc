//
//  UIViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIViewProcessor.h"

@interface UIViewProcessor (Private)

- (void)constructor;
- (void)properties;

@end


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

- (void)processDictionary:(NSDictionary *)dictionary into:(NSMutableString *)outputString
{
    dict = dictionary;
    output = outputString;
    [self constructor];
    [self properties];
}

#pragma mark -
#pragma mark Private methods

- (void)constructor
{
    NSPoint point = NSPointFromString([dict objectForKey:@"frameOrigin"]);
    NSSize size = NSSizeFromString([dict objectForKey:@"frameSize"]);
    [output appendFormat:@"%@ *instance = [[%@ alloc] initWithFrame:CGRectMake(%1.1f, %1.1f, %1.1f, %1.1f)];\n", klass, klass, point.x, point.y, size.width, size.height];
}

- (void)properties
{
    for (id item in dict)
    {
        id value = [dict objectForKey:item];
        if ([value isKindOfClass:[NSNumber class]])
        {
            [output appendFormat:@"instance.%@ = %@;\n", item, [NSString stringWithCString:[value objCType]]];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            [output appendFormat:@"instance.%@ = @\"%@\";\n", item, value];
        }
    }
}

@end
