//
//  UILabelProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
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
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else if ([item isEqualToString:@"textAlignment"])
    {
        [output setObject:[value textAlignmentString] forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output setObject:[value colorString] forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output setObject:[value fontString] forKey:item];
    }
    else if ([item isEqualToString:@"adjustsFontSizeToFitWidth"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"minimumFontSize"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"baselineAdjustment"])
    {
        [output setObject:[value baselineAdjustmentString] forKey:item];
    }
    else if ([item isEqualToString:@"lineBreakMode"])
    {
        [output setObject:[value lineBreakModeString] forKey:item];
    }
    else if ([item isEqualToString:@"numberOfLines"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"shadowOffset"])
    {
        [output setObject:[value sizeString] forKey:item];
    }
    else if ([item isEqualToString:@"shadowColor"])
    {
        [output setObject:[value colorString] forKey:item];
    }
    else if ([item isEqualToString:@"highlightedColor"])
    {
        [output setObject:[value colorString] forKey:@"highlightedTextColor"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
