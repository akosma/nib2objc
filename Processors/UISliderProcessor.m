//
//  UISliderProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UISliderProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISliderProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISlider";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"continuous"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"maxValue"])
    {
        NSString *stringOutput = [value floatString];
        [output setObject:stringOutput forKey:@"maximumValue"];
    }
    else if ([item isEqualToString:@"minValue"])
    {
        NSString *stringOutput = [value floatString];
        [output setObject:stringOutput forKey:@"minimumValue"];
    }
    else if ([item isEqualToString:@"value"])
    {
        NSString *stringOutput = [value floatString];
        [output setObject:stringOutput forKey:@"value"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
