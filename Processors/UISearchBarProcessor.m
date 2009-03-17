//
//  UISearchBarProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UISearchBarProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"

@implementation UISearchBarProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISearchBar";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"tintColor"])
    {
        [output setObject:[value colorString] forKey:item];
    }
    else if ([item isEqualToString:@"showsBookmarkButton"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"showsCancelButton"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"text"])
    {
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else if ([item isEqualToString:@"placeholder"])
    {
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else if ([item isEqualToString:@"prompt"])
    {
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else if ([item isEqualToString:@"barStyle"])
    {
        [output setObject:[value barStyleString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
