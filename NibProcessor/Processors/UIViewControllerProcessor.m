//
//  UIViewControllerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIViewControllerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIViewControllerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIViewController";
}

- (void)processKey:(id)item value:(id)value
{
    id object = nil;
    if ([item isEqualToString:@"class"])
    {
        object = [self getProcessedClassName];
    }
    else if ([item isEqualToString:@"definesPresentationContext"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"hidesBottomBarWhenPushed"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"wantsFullScreenLayout"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"providesPresentationContextTransitionStyle"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"modalPresentationStyle"])
    {
        object = [value modalPresentationStyleString];
    }
    else if ([item isEqualToString:@"modalTransitionStyle"])
    {
        object = [value modalTransitionStyleString];
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
