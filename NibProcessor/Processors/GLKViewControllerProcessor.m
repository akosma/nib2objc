//
//  GLKViewControllerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "GLKViewControllerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation GLKViewControllerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"GLKViewController";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"pauseOnWillResignActive"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"preferredFramesPerSecond"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"resumeOnDidBecomeActive"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
