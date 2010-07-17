//
//  UINavigationBarProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UINavigationBarProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UINavigationBarProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UINavigationBar";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"tintColor"])
    {
        [output setObject:[value colorString] forKey:item];
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
