//
//  UIToolbarProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UIToolbarProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIToolbarProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIToolbar";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"tintColor"])
    {
        // As of the iPhone SDK 2.2.1, this property does not seem
        // to be exported at all by Interface Builder.
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
