//
//  UITapGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UITapGestureRecognizerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UITapGestureRecognizerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITapGestureRecognizer";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"numberOfTapsRequired"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"numberOfTouchesRequired"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
