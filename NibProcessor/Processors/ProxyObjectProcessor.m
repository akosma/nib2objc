//
//  ProxyObjectProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "ProxyObjectProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation ProxyObjectProcessor

RegisterOnLoadWithCustom("IBProxyObject")

#pragma mark - Private methods

+ (NSString *)processedClassName
{
    return @"NSProxy";
}

- (void)processKey:(id)item value:(id)value
{
    // Subclasses can override this method for their own properties.
    // In those cases, call [super processUnknownProperty:item value:value];
    // to be sure that mother classes do their work too.
    
    id object = nil;
    if ([item isEqualToString:@"custom-class"])
    {
        [output setObject:value forKey:@"class"];
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
