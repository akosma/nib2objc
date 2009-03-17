//
//  UITableViewCellProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import "UITableViewCellProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITableViewCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITableViewCell";
}

- (NSString *)constructorString
{
    NSString *reuseIdentifier = [[self.input objectForKey:@"reuseIdentifier"] quotedAsCodeString];
    NSString *frame = [self frameString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@ reuseIdentifier:%@]", [self getProcessedClassName], frame, reuseIdentifier];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"textAlignment"])
    {
        [output setObject:[value textAlignmentString] forKey:item];
    }
    else if ([item isEqualToString:@"lineBreakMode"])
    {
        [output setObject:[value lineBreakModeString] forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output setObject:[value colorString] forKey:item];
    }
    else if ([item isEqualToString:@"selectedTextColor"])
    {
        [output setObject:[value colorString] forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output setObject:[value fontString] forKey:item];
    }
    else if ([item isEqualToString:@"showsReorderControl"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"hidesAccessoryWhenEditing"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"indentationWidth"])
    {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"indentationLevel"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"accessoryType"])
    {
        [output setObject:[value tableViewCellAccessoryString] forKey:item];
    }
    else if ([item isEqualToString:@"selectionStyle"])
    {
        [output setObject:[value tableViewCellSelectionStyleString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
