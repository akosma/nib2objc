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

RegisterOnLoadWithIB

- (void)processKey:(id)item value:(id)value {
    if ([item isEqualToString:@"text"]) {
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else if ([item isEqualToString:@"textAlignment"]) {
        [output setObject:[value uiTextAlignmentString] forKey:item];
    }
    else if ([item isEqualToString:@"textColor"]) {
        [output setObject:[value uiColorString] forKey:item];
    }
    else if ([item isEqualToString:@"font"]) {
        [output setObject:[value uiFontString] forKey:item];
    }
    else if ([item isEqualToString:@"adjustsFontSizeToFitWidth"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"minimumFontSize"]) {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"enabled"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"baselineAdjustment"]) {
        [output setObject:[value uiBaselineAdjustmentString] forKey:item];
    }
    else if ([item isEqualToString:@"lineBreakMode"]) {
        [output setObject:[value uiLineBreakModeString] forKey:item];
    }
    else if ([item isEqualToString:@"numberOfLines"]) {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"shadowOffset"]) {
        [output setObject:[value cgSizeString] forKey:item];
    }
    else if ([item isEqualToString:@"shadowColor"]) {
        [output setObject:[value uiColorString] forKey:item];
    }
    else if ([item isEqualToString:@"highlightedColor"]) {
        [output setObject:[value uiColorString] forKey:@"highlightedTextColor"];
    }
    else {
        [super processKey:item value:value];
    }
}

@end
