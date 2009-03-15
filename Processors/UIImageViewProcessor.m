//
//  UIImageViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewProcessor.h"

@implementation UIImageViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIImageView";
}

- (void)processKey:(id)item value:(id)value
{
    // The image property cannot be retrieved by ibtool, 
    // so here we just add the property with a nil value.
    [output setObject:@"nil" forKey:@"image"];
    [super processKey:item value:value];
}

@end
