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

RegisterOnLoadWithIB

- (void)processKey:(id)item value:(id)value {
    if ([item isEqualToString:@"drawableColorFormat"]) {
        [output setObject:[value glkDrawableColorFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableDepthFormat"]) {
        [output setObject:[value glkDrawableDepthFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableMultisample"]) {
        [output setObject:[value glkDrawableMultisampleString] forKey:item];
    }
    else if ([item isEqualToString:@"drawableStencilFormat"]) {
        [output setObject:[value glkDrawableStencilFormatString] forKey:item];
    }
    else if ([item isEqualToString:@"enableSetNeedsDisplay"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else {
        [super processKey:item value:value];
    }
}

@end
