//
//  UIControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UIControlProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIControlProcessor

- (void)dealloc
{
    [super dealloc];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"contentHorizontalAlignment"])
    {
        [output setObject:[value contentHorizontalAlignmentString] forKey:item];
    }
    else if ([item isEqualToString:@"contentVerticalAlignment"])
    {
        [output setObject:[value contentVerticalAlignmentString] forKey:item];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"highlighted"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"selected"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
