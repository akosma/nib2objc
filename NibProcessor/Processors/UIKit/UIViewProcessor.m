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

RegisterOnLoadWithIB

#pragma mark -
#pragma mark Private methods

- (NSString *)frameString {
    NSString *rect = [NSString cgRectStringFromPoint:[self.input objectForKey:@"frameOrigin"] size:[self.input objectForKey:@"frameSize"]];
    return rect;
}

- (NSString *)getProcessedClassName
{
    NSString *customClass = [self.input objectForKey:@"custom-class"];
    if (customClass) return customClass;
    return [super getProcessedClassName];
}

- (NSString *)constructorString {
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:%@]", [self getProcessedClassName], [self frameString]];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"opaqueForDevice"]) {
        item = @"opaque";
    } else if ([item isEqualToString:@"clipsSubViews"]) {
        item = @"clipsToBounds";
    }
    
    [super processKey:item value:value];
}

#pragma mark value methods

BooleanKey(autoresizesSubviews)
BooleanKey(hidden)
BooleanKey(enabled)
BooleanKey(opaque)
BooleanKey(clipsToBounds)
BooleanKey(clearsContextBeforeDrawing)
BooleanKey(userInteractionEnabled)
BooleanKey(multipleTouchEnabled)
FloatKey(alpha)
IntKey(tag)
KeyValueMethod(backgroundColor, uiColorString)
KeyValueMethod(contentMode, uiContentModeString)
KeyValueMethod(autoresizingMask, uiAutoresizingMaskString)
KeyExpressionMethod(contentStretch, ([NSString stringWithFormat:@"CGRectFromString(@\"%@\")", value]))

@end
