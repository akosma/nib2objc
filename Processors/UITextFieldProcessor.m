//
//  UITextFieldProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UITextFieldProcessor.h"

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

- (void)processUnknownProperty:(id)item value:(id)value
{
    if ([item isEqualToString:@"text"])
    {
        [output appendFormat:@"%@.text = %@;\n", instanceName, value];
    }
    else if ([item isEqualToString:@"placeholder"])
    {
        [output appendFormat:@"%@.placeholder = %@;\n", instanceName, value];
    }
    else if ([item isEqualToString:@"textAlignment"])
    {
        [output appendFormat:@"%@.textAlignment = %@;\n", instanceName, [self textAlignmentFromValue:value]];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output appendFormat:@"%@.textColor = %@;\n", instanceName, [self colorFromValue:value]];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output appendFormat:@"%@.font = %@;\n", instanceName, [self fontFromValue:value]];
    }
    else if ([item isEqualToString:@"borderStyle"])
    {
        [output appendFormat:@"%@.borderStyle = %@\n", instanceName, [self borderStyleFromValue:value]];
    }
    else if ([item isEqualToString:@"clearsOnBeginEditing"])
    {
        [output appendFormat:@"%@.clearsOnBeginEditing = %@\n", instanceName, [self booleanFromValue:value]];
    }
    else if ([item isEqualToString:@"adjustsFontSizeToFitWidth"])
    {
        [output appendFormat:@"%@.adjustsFontSizeToFitWidth = %@\n", instanceName, [self booleanFromValue:value]];
    }
    else if ([item isEqualToString:@"minimumFontSize"])
    {
        [output appendFormat:@"%@.minimumFontSize = %1.1f\n", instanceName, [value floatValue]];
    }
    else
    {
        [output appendFormat:@"/* property skipped: %@ = %@ */\n", item, value];    
    }
}

@end
