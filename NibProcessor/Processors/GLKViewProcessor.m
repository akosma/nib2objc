//
//  GLKViewProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "GLKViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation GLKViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"GLKView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"drawableColorFormat"])
    {
        [output setObject:[value drawableColorFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableDepthFormat"])
    {
        [output setObject:[value drawableDepthFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableMultisample"])
    {
        [output setObject:[value drawableMultisampleString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableStencilFormat"])
    {
        [output setObject:[value drawableStencilFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"enableSetNeedsDisplay"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
