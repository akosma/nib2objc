//
//  UITextViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UITextViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITextViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITextView";
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
    else if ([item isEqualToString:@"font"])
    {
        NSString *stringOutput = [value fontString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        NSString *stringOutput = [value colorString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"editable"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
