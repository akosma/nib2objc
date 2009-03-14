//
//  NSDictionary+Nib2ObjcExtensions.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation NSDictionary (Nib2ObjcExtensions)

- (NSString *)fontString
{
    NSString *name = [self objectForKey:@"Name"];
    float size = [[self objectForKey:@"Size"] floatValue];
    return [NSString stringWithFormat:@"[UIFont fontWithName:@\"%@\" size:%1.3f]", name, size];
}

@end
