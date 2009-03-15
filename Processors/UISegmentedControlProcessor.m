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

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISegmentedControl";
}

- (NSString *)constructorString
{
    NSString *items = [[self.input objectForKey:@"segmentTitles"] componentsJoinedByString:@"\", @\""];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithItems:[NSArray arrayWithObjects:%@, nil]]", [self getProcessedClassName], [items quotedAsCodeString]];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"segmentControlStyle"])
    {
        NSString *stringOutput = [value segmentedControlStyleString];
        [output setObject:stringOutput forKey:@"segmentedControlStyle"];
    }
    else if ([item isEqualToString:@"selectedSegmentIndex"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%d", [value intValue]];
        [output setObject:stringOutput forKey:item];
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
