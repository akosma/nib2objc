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

- (NSString *)constructorString;
- (NSString *)frameString;

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
    [output setObject:[self constructorString] forKey:@"constructor"];
    [output setObject:[self frameString] forKey:@"frame"];
    
    for (id item in input)
    {
        id value = [input objectForKey:item];
        [self processKey:item value:value];
    }
    
    return output;
}

#pragma mark -
#pragma mark Private methods

- (NSString *)frameString
{
    NSString *rect = [NSString rectStringFromPoint:[input objectForKey:@"frameOrigin"] size:[input objectForKey:@"frameSize"]];
    return rect;
}

- (NSString *)constructorString
{
    // Some subclasses have different constructors than the classic
    // "initWithFrame:", and as such they should override this method.
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@]", klass, [self frameString]];
}

- (void)processKey:(id)item value:(id)value
{
    // Subclasses can override this method for their own properties.
    // In those cases, call [super processUnknownProperty:item value:value];
    // to be sure that mother classes do their work too.

    // Use the line below for debugging and development
    // id object = [NSString stringWithFormat:@"// unknown property: %@", value];
    
    id object = nil;
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
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
