//
//  NSNumber+Nib2ObjcExtensions.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+Nib2ObjcExtensions.h"

@implementation NSNumber (Nib2ObjcExtensions)

- (NSString *)contentModeString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UIViewContentModeScaleToFill";
            break;
            
        case 1:
            value = @"UIViewContentModeScaleAspectFit";
            break;
            
        case 2:
            value = @"UIViewContentModeScaleAspectFill";
            break;
            
        case 3:
            value = @"UIViewContentModeRedraw";
            break;
            
        case 4:
            value = @"UIViewContentModeCenter";
            break;
            
        case 5:
            value = @"UIViewContentModeTop";
            break;
            
        case 6:
            value = @"UIViewContentModeBottom";
            break;
            
        case 7:
            value = @"UIViewContentModeLeft";
            break;
            
        case 8:
            value = @"UIViewContentModeRight";
            break;
            
        case 9:
            value = @"UIViewContentModeTopLeft";
            break;
            
        case 10:
            value = @"UIViewContentModeTopRight";
            break;
            
        case 11:
            value = @"UIViewContentModeBottomLeft";
            break;
            
        case 12:
            value = @"UIViewContentModeBottomRight";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)booleanString
{
    return ([self boolValue] == 1) ? @"YES" : @"NO";
}

- (NSString *)autoresizingMaskString
{
    // From the documentation
    enum 
    {
        UIViewAutoresizingNone                 = 0,
        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
        UIViewAutoresizingFlexibleWidth        = 1 << 1,
        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
        UIViewAutoresizingFlexibleHeight       = 1 << 4,
        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
    };
    
    NSUInteger mask = [self intValue];
    NSMutableString *maskValue = [[[NSMutableString alloc] init] autorelease];
    
    if (mask == UIViewAutoresizingNone) 
    {
        [maskValue appendString:@"UIViewAutoresizingNone"];
    }
    if ((mask & UIViewAutoresizingFlexibleLeftMargin) == UIViewAutoresizingFlexibleLeftMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleLeftMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleWidth) == UIViewAutoresizingFlexibleWidth)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleWidth"];
    }
    if ((mask & UIViewAutoresizingFlexibleRightMargin) == UIViewAutoresizingFlexibleRightMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleRightMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleTopMargin) == UIViewAutoresizingFlexibleTopMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleTopMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleHeight) == UIViewAutoresizingFlexibleHeight)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleHeight"];
    }
    if ((mask & UIViewAutoresizingFlexibleBottomMargin) == UIViewAutoresizingFlexibleBottomMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleBottomMargin"];
    }
    
    return maskValue;
}

- (NSString *)textAlignmentString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UITextAlignmentLeft";
            break;
            
        case 1:
            value = @"UITextAlignmentCenter";
            break;
            
        case 2:
            value = @"UITextAlignmentRight";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)borderStyleString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UITextBorderStyleNone";
            break;
            
        case 1:
            value = @"UITextBorderStyleLine";
            break;
            
        case 2:
            value = @"UITextBorderStyleBezel";
            break;
            
        case 3:
            value = @"UITextBorderStyleRoundedRect";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)contentHorizontalAlignmentString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UIControlContentHorizontalAlignmentCenter";
            break;
            
        case 1:
            value = @"UIControlContentHorizontalAlignmentLeft";
            break;
            
        case 2:
            value = @"UIControlContentHorizontalAlignmentRight";
            break;
            
        case 3:
            value = @"UIControlContentHorizontalAlignmentFill";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)contentVerticalAlignmentString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UIControlContentVerticalAlignmentCenter";
            break;
            
        case 1:
            value = @"UIControlContentVerticalAlignmentTop";
            break;
            
        case 2:
            value = @"UIControlContentVerticalAlignmentBottom";
            break;
            
        case 3:
            value = @"UIControlContentVerticalAlignmentFill";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)keyboardAppearanceString
{
    NSString *value = @"";
    switch ([self intValue])
    {
        case 0:
            value = @"UIKeyboardAppearanceDefault";
            break;
        
        case 1:
            value = @"UIKeyboardAppearanceAlert";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)returnKeyTypeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIReturnKeyDefault";
            break;

        case 1:
            value = @"UIReturnKeyGo";
            break;
            
        case 2:
            value = @"UIReturnKeyGoogle";
            break;
            
        case 3:
            value = @"UIReturnKeyJoin";
            break;
            
        case 4:
            value = @"UIReturnKeyNext";
            break;
            
        case 5:
            value = @"UIReturnKeyRoute";
            break;
            
        case 6:
            value = @"UIReturnKeySearch";
            break;
            
        case 7:
            value = @"UIReturnKeySend";
            break;
            
        case 8:
            value = @"UIReturnKeyYahoo";
            break;
            
        case 9:
            value = @"UIReturnKeyDone";
            break;
            
        case 10:
            value = @"UIReturnKeyEmergencyCall";
            break;

        default:
            break;
    }
    return value;
}

- (NSString *)autocapitalizationTypeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UITextAutocapitalizationTypeNone";
            break;
            
        case 1:
            value = @"UITextAutocapitalizationTypeWords";
            break;
            
        case 2:
            value = @"UITextAutocapitalizationTypeSentences";
            break;
            
        case 3:
            value = @"UITextAutocapitalizationTypeAllCharacters";
            break;

        default:
            break;
    }
    return value;
}

- (NSString *)autocorrectionTypeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UITextAutocorrectionTypeDefault";
            break;
            
        case 1:
            value = @"UITextAutocorrectionTypeNo";
            break;
            
        case 2:
            value = @"UITextAutocorrectionTypeYes";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)keyboardTypeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIKeyboardTypeDefault";
            break;
            
        case 1:
            value = @"UIKeyboardTypeASCIICapable";
            break;
            
        case 2:
            value = @"UIKeyboardTypeNumbersAndPunctuation";
            break;
            
        case 3:
            value = @"UIKeyboardTypeURL";
            break;
            
        case 4:
            value = @"UIKeyboardTypeNumberPad";
            break;
            
        case 5:
            value = @"UIKeyboardTypePhonePad";
            break;
            
        case 6:
            value = @"UIKeyboardTypeNamePhonePad";
            break;
            
        case 7:
            value = @"UIKeyboardTypeEmailAddress";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)progressViewStyleString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIProgressViewStyleDefault";
            break;
            
        case 1:
            value = @"UIProgressViewStyleBar";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)baselineAdjustmentString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIBaselineAdjustmentAlignBaselines";
            break;
            
        case 1:
            value = @"UIBaselineAdjustmentAlignCenters";
            break;
            
        case 2:
            value = @"UIBaselineAdjustmentNone";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)lineBreakModeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UILineBreakModeWordWrap";
            break;

        case 1:
            value = @"UILineBreakModeCharacterWrap";
            break;

        case 2:
            value = @"UILineBreakModeClip";
            break;

        case 3:
            value = @"UILineBreakModeHeadTruncation";
            break;

        case 4:
            value = @"UILineBreakModeTailTruncation";
            break;

        case 5:
            value = @"UILineBreakModeMiddleTruncation";
            break;

        default:
            break;
    }
    return value;
}

- (NSString *)activityIndicatorViewStyleString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIActivityIndicatorViewStyleWhiteLarge";
            break;
            
        case 1:
            value = @"UIActivityIndicatorViewStyleWhite";
            break;
            
        case 2:
            value = @"UIActivityIndicatorViewStyleGray";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)buttonTypeString
{
    NSString *value = @"";
    switch ([self intValue]) 
    {
        case 0:
            value = @"UIButtonTypeCustom";
            break;
            
        case 1:
            value = @"UIButtonTypeRoundedRect";
            break;
            
        case 2:
            value = @"UIButtonTypeDetailDisclosure";
            break;
            
        case 3:
            value = @"UIButtonTypeInfoLight";
            break;
            
        case 4:
            value = @"UIButtonTypeInfoDark";
            break;
            
        case 5:
            value = @"UIButtonTypeContactAdd";
            break;
            
        default:
            break;
    }
    return value;
}

@end
