//
//  UIViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Adrian Kosmaczewski 2009
//

#import "UIViewProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIViewProcessor

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Private methods

- (NSString *)getProcessedClassName
{
    return @"UIView";
}

- (NSString *)frameString
{
    NSString *rect = [NSString rectStringFromPoint:[self.input objectForKey:@"frameOrigin"] size:[self.input objectForKey:@"frameSize"]];
    return rect;
}

- (NSString *)constructorString
{
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@]", [self getProcessedClassName], [self frameString]];
}

- (void)processKey:(id)item value:(id)value
{
    // Subclasses can override this method for their own properties.
    // In those cases, call [super processUnknownProperty:item value:value];
    // to be sure that mother classes do their work too.

    id object = nil;
    if ([item isEqualToString:@"class"])
    {
        object = [self getProcessedClassName];
    }
    else if ([item isEqualToString:@"autoresizesSubviews"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"contentStretch"])
    {
        object = [NSString stringWithFormat:@"CGRectFromString(@\"%@\")", value];
    }
    else if ([item isEqualToString:@"alpha"])
    {
        object = [value floatString];
    }
    else if ([item isEqualToString:@"hidden"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"opaqueForDevice"])
    {
        object = [value booleanString];
        item = @"opaque";
    }
    else if ([item isEqualToString:@"clipsSubviews"])
    {
        object = [value booleanString];
        item = @"clipsToBounds";
    }
    else if ([item isEqualToString:@"clearsContextBeforeDrawing"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"userInteractionEnabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"multipleTouchEnabled"])
    {
        object = [value booleanString];
    }
    else if ([item isEqualToString:@"tag"])
    {
        object = [value intString];
    }
    else if ([item isEqualToString:@"backgroundColor"])
    {
        object = [value colorString];
    }
    else if ([item isEqualToString:@"contentMode"])
    {
        object = [value contentModeString];
    }
    else if ([item isEqualToString:@"autoresizingMask"])
    {
        object = [value autoresizingMaskString];
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
