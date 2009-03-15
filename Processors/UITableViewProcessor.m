//
//  UITableViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UITableViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UITableViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITableView";
}

- (NSString *)constructorString
{
    NSString *style = [[self.input objectForKey:@"style"] tableViewStyleString];
    NSString *frame = [self frameString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@ style:%@]", [self getProcessedClassName], frame, style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"separatorStyle"])
    {
        NSString *stringOutput = [value tableViewCellSeparatorStyleString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"sectionIndexMinimumDisplayRowCount"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%d", [value intValue]];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"allowsSelectionDuringEditing"])
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
