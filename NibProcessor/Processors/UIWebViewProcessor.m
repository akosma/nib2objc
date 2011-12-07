//
//  UIWebViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Adrian Kosmaczewski 2009
//

#import "UIWebViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIWebViewProcessor

RegisterOnLoadWithIB

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"scalesPageToFit"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"detectsPhoneNumbers"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
