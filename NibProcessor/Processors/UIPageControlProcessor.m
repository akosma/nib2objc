//
//  UIPageControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UIPageControlProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIPageControlProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIPageControl";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"currentPage"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"numberOfPages"])
    {
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"hidesForSinglePage"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"defersCurrentPageDisplay"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }    
}

@end
