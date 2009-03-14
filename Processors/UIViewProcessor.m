//
//  UIViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIViewProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@interface UIViewProcessor (Private)

- (void)constructor;

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

- (NSDictionary *)processObject:(NSDictionary *)object
{
    input = object;
    [output release];
    output = [[NSMutableDictionary alloc] init];
    [self constructor];

    for (id item in input)
    {
        id value = [input objectForKey:item];
        [self processKey:item value:value];
    }
    
    return output;
}

#pragma mark -
#pragma mark Private methods

- (void)constructor
{
    NSString *rect = [NSString rectStringFromPoint:[input objectForKey:@"frameOrigin"] size:[input objectForKey:@"frameSize"]];
    NSString *stringObject = [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@]", klass, rect];
    [output setObject:stringObject forKey:@"constructor"];
}

- (void)processKey:(id)item value:(id)value
{
    // Subclasses can override this method for their own properties.
    // In those cases, call [super processUnknownProperty:item value:value];
    // to be sure that mother classes do their work too.
    id object = [NSString stringWithFormat:@"// unknown property: %@", value];
    if ([item isEqualToString:@"class"])
    {
        object = klass;
    }
    else if ([item isEqualToString:@"alpha"])
    {
        object = [NSString stringWithFormat:@"%1.1f", [value floatValue]];
    }
    else if ([item isEqualToString:@"hidden"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"opaqueForDevice"])
    {
        object = [value booleanString];
        item = @"opaque";
    }
    else if ([item isEqualToString:@"clipsSubviews"])
    {
        object = [value booleanString];
        item = @"clipsToBounds";
    }
    else if ([item isEqualToString:@"clearsContextBeforeDrawing"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"userInteractionEnabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"multipleTouchEnabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"tag"])
    {
        object = [NSString stringWithFormat:@"%d", [value intValue]];
    }
    else if ([item isEqualToString:@"backgroundColor"])
    {
        object = [value colorString];
    }
    else if ([item isEqualToString:@"contentMode"])
    {
        object = [value contentModeString];
    }
    else if ([item isEqualToString:@"autoresizingMask"])
    {
        object = [value autoresizingMaskString];
    }
    [output setObject:object forKey:item];
}

@end
