//
//  UISegmentedControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UISegmentedControlProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISegmentedControlProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UISegmentedControl";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)constructorString
{
    NSString *items = [[input objectForKey:@"segmentTitles"] componentsJoinedByString:@"\", @\""];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithItems:[NSArray arrayWithObjects:%@, nil]]", klass, [items quotedAsCodeString]];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"segmentControlStyle"])
    {
        NSString *stringOutput = [value segmentedControlStyleString];
        [output setObject:stringOutput forKey:@"segmentedControlStyle"];
    }
    else if ([item isEqualToString:@"momentary"])
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
