//
//  UITableViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Adrian Kosmaczewski 2009
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
    if ([item isEqualToString:@"rowHeight"])
    {
        [output setObject:[value description] forKey:item];
    }
    else if ([item isEqualToString:@"sectionFooterHeight"])
    {
        [output setObject:[value description] forKey:item];
    }
    else if ([item isEqualToString:@"sectionHeaderHeight"])
    {
        [output setObject:[value description] forKey:item];
    }
    else if ([item isEqualToString:@"separatorStyle"])
    {
        [output setObject:[value tableViewCellSeparatorStyleString] forKey:item];
    }
    else if ([item isEqualToString:@"sectionIndexMinimumDisplayRowCount"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"allowsMultipleSelection"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"allowsMultipleSelectionDuringEditing"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"allowsSelection"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"allowsSelectionDuringEditing"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
