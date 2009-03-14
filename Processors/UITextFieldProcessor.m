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

- (id)init
{
    if (self = [super init])
    {
        klass = @"UITextField";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    else
    {
        [super processKey:item value:value];
    }
}

@end
