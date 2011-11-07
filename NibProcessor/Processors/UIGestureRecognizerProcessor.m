//
//  UIGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIGestureRecognizerProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIGestureRecognizerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIGestureRecognizer";
}

- (void)processKey:(id)item value:(id)value
{
    id object = nil;
    if ([item isEqualToString:@"class"])
    {
        object = [self getProcessedClassName];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"cancelsTouchesInView"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"delaysTouchesBegan"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"delaysTouchesEnded"])
    {
        object = [value booleanString];
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
