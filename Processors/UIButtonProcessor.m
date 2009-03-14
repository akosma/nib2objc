//
//  UIButtonProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIButtonProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"

@implementation UIButtonProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIButton";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)constructorString
{
    NSString *style = [[input objectForKey:@"buttonType"] buttonTypeString];
    return [NSString stringWithFormat:@"[%@ buttonWithType:%@]", klass, style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"adjustsImageWhenDisabled"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"adjustsImageWhenHighlighted"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        NSString *stringOutput = [value fontString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"lineBreakMode"])
    {
        NSString *stringOutput = [value lineBreakModeString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"reversesTitleShadowWhenHighlighted"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"showsTouchWhenHighlighted"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"titleShadowOffset"])
    {
        NSString *stringOutput = [NSString sizeStringFromSize:value];
        [output setObject:stringOutput forKey:item];
    }

    // Creation of methods for the titles, instead of properties
    else if ([item isEqualToString:@"normalTitle"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitle:%@ forState:UIControlStateNormal", [value quotedAsCodeString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"selectedTitle"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitle:%@ forState:UIControlStateSelected", [value quotedAsCodeString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"highlightedTitle"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitle:%@ forState:UIControlStateHighlighted", [value quotedAsCodeString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"disabledTitle"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitle:%@ forState:UIControlStateDisabled", [value quotedAsCodeString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }

    // Creation of methods for the title colors, instead of properties
    else if ([item isEqualToString:@"normalTitleColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleColor:%@ forState:UIControlStateNormal", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"selectedTitleColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleColor:%@ forState:UIControlStateSelected", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"highlightedTitleColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleColor:%@ forState:UIControlStateHighlighted", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"disabledTitleColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleColor:%@ forState:UIControlStateDisabled", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    
    // Creation of methods for the title shadow colors, instead of properties
    else if ([item isEqualToString:@"normalTitleShadowColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleShadowColor:%@ forState:UIControlStateNormal", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"selectedTitleShadowColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleShadowColor:%@ forState:UIControlStateSelected", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"highlightedTitleShadowColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleShadowColor:%@ forState:UIControlStateHighlighted", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else if ([item isEqualToString:@"disabledTitleShadowColor"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"setTitleShadowColor:%@ forState:UIControlStateDisabled", [value colorString]];
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    
    else
    {
        [super processKey:item value:value];
    }
}

@end
