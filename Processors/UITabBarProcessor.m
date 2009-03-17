//
//  UITabBarProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UITabBarProcessor.h"

@implementation UITabBarProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITabBar";
}

// This class does not override 
// - (void)processKey:(id)item value:(id)value

@end
