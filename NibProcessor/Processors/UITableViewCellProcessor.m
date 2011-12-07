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

RegisterOnLoadWithIB

- (NSString *)constructorString {
    NSString *reuseIdentifier = [[self.input objectForKey:@"reuseIdentifier"] quotedAsCodeString];
    if (reuseIdentifier == nil) {
        reuseIdentifier = @"@\"UITableViewCellReuseIdentifier\"";
    }
    return [NSString stringWithFormat:@"[[%@ alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:%@]", [self getProcessedClassName], reuseIdentifier];
}

- (void)processKey:(id)item value:(id)value {
    if ([item isEqualToString:@"textAlignment"]) {
        [output setObject:[value uiTextAlignmentString] forKey:@"textLabel.textAlignment"];
        [output setObject:[value uiTextAlignmentString] forKey:@"detailTextLabel.textAlignment"];
    }
    else if ([item isEqualToString:@"lineBreakMode"]) {
        [output setObject:[value uiLineBreakModeString] forKey:@"textLabel.lineBreakMode"];
        [output setObject:[value uiLineBreakModeString] forKey:@"detailTextLabel.lineBreakMode"];
    }
    else if ([item isEqualToString:@"textColor"]) {
        [output setObject:[value uiColorString] forKey:@"textLabel.textColor"];
        [output setObject:[value uiColorString] forKey:@"detailTextLabel.textColor"];
    }
    else if ([item isEqualToString:@"selectedTextColor"]) {
        [output setObject:[value uiColorString] forKey:@"textLabel.highlightedTextColor"];
        [output setObject:[value uiColorString] forKey:@"detailTextLabel.highlightedTextColor"];
    }
    else if ([item isEqualToString:@"font"]) {
        [output setObject:[value uiFontString] forKey:@"textLabel.font"];
        [output setObject:[value uiFontString] forKey:@"detailTextLabel.font"];
    }
    else if ([item isEqualToString:@"showsReorderControl"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"shouldIndentWhileEditing"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"indentationWidth"]) {
        [output setObject:[value floatString] forKey:item];
    }
    else if ([item isEqualToString:@"indentationLevel"]) {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"accessoryType"]) {
        [output setObject:[value uiTableViewCellAccessoryString] forKey:item];
    }
    else if ([item isEqualToString:@"editingAccessoryType"]) {
        [output setObject:[value uiTableViewCellAccessoryString] forKey:item];
    }
    else if ([item isEqualToString:@"selectionStyle"]) {
        [output setObject:[value uiTableViewCellSelectionStyleString] forKey:item];
    }
    else {
        [super processKey:item value:value];
    }
}

@end
