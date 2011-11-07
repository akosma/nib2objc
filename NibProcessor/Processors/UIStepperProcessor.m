//
//  UIStepperProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIStepperProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIStepperProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIStepper";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"autorepeat"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"continuous"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"maximumValue"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"minimumValue"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"stepValue"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"value"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"wraps"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
