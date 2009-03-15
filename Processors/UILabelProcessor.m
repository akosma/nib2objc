//
//  UILabelProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UILabelProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UILabelProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UILabel";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"text"])
    {
        NSString *stringOutput = [value quotedAsCodeString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"textAlignment"])
    {
        NSString *stringOutput = [value textAlignmentString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        NSString *stringOutput = [value colorString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        NSString *stringOutput = [value fontString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"adjustsFontSizeToFitWidth"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"minimumFontSize"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.1f", [value floatValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"baselineAdjustment"])
    {
        NSString *stringOutput = [value baselineAdjustmentString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"lineBreakMode"])
    {
        NSString *stringOutput = [value lineBreakModeString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"numberOfLines"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%d", [value intValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"shadowOffset"])
    {
        NSString *stringOutput = [NSString sizeStringFromSize:value];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"shadowColor"])
    {
        NSString *stringOutput = [value colorString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"highlightedColor"])
    {
        NSString *stringOutput = [value colorString];
        [output setObject:stringOutput forKey:@"highlightedTextColor"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
