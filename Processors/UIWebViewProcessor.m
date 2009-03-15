//
//  UIWebViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIWebViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIWebViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIWebView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"scalesPageToFit"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"detectsPhoneNumbers"])
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
