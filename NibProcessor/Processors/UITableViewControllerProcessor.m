//
//  UITableViewControllerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UITableViewControllerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UITableViewControllerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITableViewController";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"clearsSelectionOnViewWillAppear"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
