//
//  UIBarItemProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UIBarItemProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIBarItemProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIBarItem";
}

- (void)processKey:(id)item value:(id)value
{
    id object = nil;
    if ([item isEqualToString:@"class"])
    {
        object = [self getProcessedClassName];
    }
    else if ([item isEqualToString:@"title"])
    {
        object = [value quotedAsCodeString];
    }
    else if ([item isEqualToString:@"tag"])
    {
        object = [value intString];
    }
    else if ([item isEqualToString:@"enabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"image"])
    {
        object = @"nil";
    }
    else if ([item isEqualToString:@"imageInsets"])
    {
        object = @"UIEdgeInsetsZero";
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
