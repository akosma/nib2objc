//
//  UITextFieldProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UITextFieldProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITextFieldProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITextField";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"text"])
    {
        NSString *stringOutput = [value quotedAsCodeString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"placeholder"])
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
    else if ([item isEqualToString:@"borderStyle"])
    {
        NSString *stringOutput = [value borderStyleString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"clearsOnBeginEditing"])
    {
        NSString *stringOutput = [value booleanString];
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
    else if ([item isEqualToString:@"textInputTraits.enablesReturnKeyAutomatically"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:@"enablesReturnKeyAutomatically"];
    }
    else if ([item isEqualToString:@"textInputTraits.secureTextEntry"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:@"secureTextEntry"];
    }
    else if ([item isEqualToString:@"textInputTraits.keyboardAppearance"])
    {
        NSString *stringOutput = [value keyboardAppearanceString];
        [output setObject:stringOutput forKey:@"keyboardAppearance"];
    }
    else if ([item isEqualToString:@"textInputTraits.returnKeyType"])
    {
        NSString *stringOutput = [value returnKeyTypeString];
        [output setObject:stringOutput forKey:@"returnKeyType"];
    }
    else if ([item isEqualToString:@"textInputTraits.autocapitalizationType"])
    {
        NSString *stringOutput = [value autocapitalizationTypeString];
        [output setObject:stringOutput forKey:@"autocapitalizationType"];
    }
    else if ([item isEqualToString:@"textInputTraits.autocorrectionType"])
    {
        NSString *stringOutput = [value autocorrectionTypeString];
        [output setObject:stringOutput forKey:@"autocorrectionType"];
    }
    else if ([item isEqualToString:@"textInputTraits.keyboardType"])
    {
        NSString *stringOutput = [value keyboardTypeString];
        [output setObject:stringOutput forKey:@"keyboardType"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
