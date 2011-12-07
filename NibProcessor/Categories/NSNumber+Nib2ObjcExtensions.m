//
//  NSNumber+Nib2ObjcExtensions.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "NSNumber+Nib2ObjcExtensions.h"

@implementation NSNumber (Nib2ObjcExtensions)

- (NSString *)booleanString {
    return ([self boolValue]) ? @"YES" : @"NO";
}

- (NSString *)intString {
    return [NSString stringWithFormat:@"%d", [self intValue]];
}

- (NSString *)floatString {
    return [NSString stringWithFormat:@"%1.3f", [self floatValue]];
}

- (NSString *)uiAutoresizingMaskString {
    // From the documentation
    enum {
        UIViewAutoresizingNone                  = 0,
        UIViewAutoresizingFlexibleLeftMargin    = 1 << 0,
        UIViewAutoresizingFlexibleWidth         = 1 << 1,
        UIViewAutoresizingFlexibleRightMargin   = 1 << 2,
        UIViewAutoresizingFlexibleTopMargin     = 1 << 3,
        UIViewAutoresizingFlexibleHeight        = 1 << 4,
        UIViewAutoresizingFlexibleBottomMargin  = 1 << 5
    };

    NSUInteger mask = [self unsignedIntValue];
    NSMutableString *maskValue = [[[NSMutableString alloc] init] autorelease];

    if (mask == UIViewAutoresizingNone) {
        [maskValue appendString:@"UIViewAutoresizingNone"];
    }
    if ((mask & UIViewAutoresizingFlexibleLeftMargin) == UIViewAutoresizingFlexibleLeftMargin) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleLeftMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleWidth) == UIViewAutoresizingFlexibleWidth) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleWidth"];
    }
    if ((mask & UIViewAutoresizingFlexibleRightMargin) == UIViewAutoresizingFlexibleRightMargin) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleRightMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleTopMargin) == UIViewAutoresizingFlexibleTopMargin) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleTopMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleHeight) == UIViewAutoresizingFlexibleHeight) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleHeight"];
    }
    if ((mask & UIViewAutoresizingFlexibleBottomMargin) == UIViewAutoresizingFlexibleBottomMargin) {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleBottomMargin"];
    }

    return maskValue;
}

- (NSString *)uiContentModeString {
    NSArray *values = [NSArray arrayWithObjects:@"UIViewContentModeScaleToFill",
                                                @"UIViewContentModeScaleAspectFit",
                                                @"UIViewContentModeScaleAspectFill",
                                                @"UIViewContentModeRedraw",
                                                @"UIViewContentModeCenter",
                                                @"UIViewContentModeTop",
                                                @"UIViewContentModeBottom",
                                                @"UIViewContentModeLeft",
                                                @"UIViewContentModeRight",
                                                @"UIViewContentModeTopLeft",
                                                @"UIViewContentModeTopRight",
                                                @"UIViewContentModeBottomLeft",
                                                @"UIViewContentModeBottomRight", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTextAlignmentString {
    NSArray *values = [NSArray arrayWithObjects:@"UITextAlignmentLeft",
                                                @"UITextAlignmentCenter",
                                                @"UITextAlignmentRight", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiBorderStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UITextBorderStyleNone",
                                                @"UITextBorderStyleLine",
                                                @"UITextBorderStyleBezel",
                                                @"UITextBorderStyleRoundedRect", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiContentHorizontalAlignmentString {
    NSArray *values = [NSArray arrayWithObjects:@"UIControlContentHorizontalAlignmentCenter",
                                                @"UIControlContentHorizontalAlignmentLeft",
                                                @"UIControlContentHorizontalAlignmentRight",
                                                @"UIControlContentHorizontalAlignmentFill", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiContentVerticalAlignmentString {
    NSArray *values = [NSArray arrayWithObjects:@"UIControlContentVerticalAlignmentCenter",
                                                @"UIControlContentVerticalAlignmentTop",
                                                @"UIControlContentVerticalAlignmentBottom",
                                                @"UIControlContentVerticalAlignmentFill", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiKeyboardAppearanceString {
    NSArray *values = [NSArray arrayWithObjects:@"UIKeyboardAppearanceDefault",
                                                @"UIKeyboardAppearanceAlert", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiReturnKeyTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"UIReturnKeyDefault",
                                                @"UIReturnKeyGo",
                                                @"UIReturnKeyGoogle",
                                                @"UIReturnKeyJoin",
                                                @"UIReturnKeyNext",
                                                @"UIReturnKeyRoute",
                                                @"UIReturnKeySearch",
                                                @"UIReturnKeySend",
                                                @"UIReturnKeyYahoo",
                                                @"UIReturnKeyDone",
                                                @"UIReturnKeyEmergencyCall", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiAutocapitalizationTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"UITextAutocapitalizationTypeNone",
                                                @"UITextAutocapitalizationTypeWords",
                                                @"UITextAutocapitalizationTypeSentences",
                                                @"UITextAutocapitalizationTypeAllCharacters", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiAutocorrectionTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"UITextAutocorrectionTypeDefault",
                                                @"UITextAutocorrectionTypeNo",
                                                @"UITextAutocorrectionTypeYes", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiKeyboardTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"UIKeyboardTypeDefault",
                                                @"UIKeyboardTypeASCIICapable",
                                                @"UIKeyboardTypeNumbersAndPunctuation",
                                                @"UIKeyboardTypeURL",
                                                @"UIKeyboardTypeNumberPad",
                                                @"UIKeyboardTypePhonePad",
                                                @"UIKeyboardTypeNamePhonePad",
                                                @"UIKeyboardTypeEmailAddress", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiProgressViewStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIProgressViewStyleDefault",
                                                @"UIProgressViewStyleBar", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiBaselineAdjustmentString {
    NSArray *values = [NSArray arrayWithObjects:@"UIBaselineAdjustmentAlignBaselines",
                                                @"UIBaselineAdjustmentAlignCenters",
                                                @"UIBaselineAdjustmentNone", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiLineBreakModeString {
    NSArray *values = [NSArray arrayWithObjects:@"UILineBreakModeWordWrap",
                                                @"UILineBreakModeCharacterWrap",
                                                @"UILineBreakModeClip",
                                                @"UILineBreakModeHeadTruncation",
                                                @"UILineBreakModeTailTruncation",
                                                @"UILineBreakModeMiddleTruncation", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiActivityIndicatorViewStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIActivityIndicatorViewStyleWhiteLarge",
                                                @"UIActivityIndicatorViewStyleWhite",
                                                @"UIActivityIndicatorViewStyleGray", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiButtonTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"UIButtonTypeCustom",
                                                @"UIButtonTypeRoundedRect",
                                                @"UIButtonTypeDetailDisclosure",
                                                @"UIButtonTypeInfoLight",
                                                @"UIButtonTypeInfoDark",
                                                @"UIButtonTypeContactAdd", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiSegmentedControlStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UISegmentedControlStylePlain",
                                                @"UISegmentedControlStyleBordered",
                                                @"UISegmentedControlStyleBar", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiScrollViewIndicatorStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIScrollViewIndicatorStyleDefault",
                                                @"UIScrollViewIndicatorStyleBlack",
                                                @"UIScrollViewIndicatorStyleWhite", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTableViewStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UITableViewStylePlain",
                                                @"UITableViewStyleGrouped", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTableViewCellSeparatorStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UITableViewCellSeparatorStyleNone",
                                                @"UITableViewCellSeparatorStyleSingleLine",
                                                @"UITableViewCellSeparatorStyleSingleLineEtched", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTableViewCellAccessoryString {
    NSArray *values = [NSArray arrayWithObjects:@"UITableViewCellAccessoryNone",
                                                @"UITableViewCellAccessoryDisclosureIndicator",
                                                @"UITableViewCellAccessoryDetailDisclosureButton",
                                                @"UITableViewCellAccessoryCheckmark", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTableViewCellEditingStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UITableViewCellEditingStyleNone",
                                                @"UITableViewCellEditingStyleDelete",
                                                @"UITableViewCellEditingStyleInsert", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTableViewCellSelectionStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UITableViewCellSelectionStyleNone",
                                                @"UITableViewCellSelectionStyleBlue",
                                                @"UITableViewCellSelectionStyleGray", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiDatePickerModeString {
    NSArray *values = [NSArray arrayWithObjects:@"UIDatePickerModeTime",
                                                @"UIDatePickerModeDate",
                                                @"UIDatePickerModeDateAndTime",
                                                @"UIDatePickerModeCountDownTimer", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiBarStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIBarStyleDefault",
                                                @"UIBarStyleBlackOpaque",
                                                @"UIBarStyleBlackTranslucent", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiBarButtonItemStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIBarButtonItemStylePlain",
                                                @"UIBarButtonItemStyleBordered",
                                                @"UIBarButtonItemStyleDone", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiBarButtonSystemItemString {
    NSArray *values = [NSArray arrayWithObjects:@"UIBarButtonSystemItemDone",
                                                @"UIBarButtonSystemItemCancel",
                                                @"UIBarButtonSystemItemEdit",
                                                @"UIBarButtonSystemItemSave",
                                                @"UIBarButtonSystemItemAdd",
                                                @"UIBarButtonSystemItemFlexibleSpace",
                                                @"UIBarButtonSystemItemFixedSpace",
                                                @"UIBarButtonSystemItemCompose",
                                                @"UIBarButtonSystemItemReply",
                                                @"UIBarButtonSystemItemAction",
                                                @"UIBarButtonSystemItemOrganize",
                                                @"UIBarButtonSystemItemBookmarks",
                                                @"UIBarButtonSystemItemSearch",
                                                @"UIBarButtonSystemItemRefresh",
                                                @"UIBarButtonSystemItemStop",
                                                @"UIBarButtonSystemItemCamera",
                                                @"UIBarButtonSystemItemTrash",
                                                @"UIBarButtonSystemItemPlay",
                                                @"UIBarButtonSystemItemPause",
                                                @"UIBarButtonSystemItemRewind",
                                                @"UIBarButtonSystemItemFastForward", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiTabBarSystemItemString {
    NSArray *values = [NSArray arrayWithObjects:@"UITabBarSystemItemMore",
                                                @"UITabBarSystemItemFavorites",
                                                @"UITabBarSystemItemFeatured",
                                                @"UITabBarSystemItemTopRated",
                                                @"UITabBarSystemItemRecents",
                                                @"UITabBarSystemItemContacts",
                                                @"UITabBarSystemItemHistory",
                                                @"UITabBarSystemItemBookmarks",
                                                @"UITabBarSystemItemSearch",
                                                @"UITabBarSystemItemDownloads",
                                                @"UITabBarSystemItemMostRecent",
                                                @"UITabBarSystemItemMostViewed", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)mmMapTypeString {
    NSArray *values = [NSArray arrayWithObjects:@"MKMapTypeStandard",
                                                @"MKMapTypeSatellite",
                                                @"MKMapTypeHybrid", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiClearButtonModeString {
    NSArray *values = [NSArray arrayWithObjects:@"UITextFieldViewModeNever",
                                                @"UITextFieldViewModeWhileEditing",
                                                @"UITextFieldViewModeUnlessEditing",
                                                @"UITextFieldViewModeAlways", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiSwipeGestureRecognizerDirectionString {
    NSArray *values = [NSArray arrayWithObjects:@"UISwipeGestureRecognizerDirectionRight",
                                                @"UISwipeGestureRecognizerDirectionLeft",
                                                @"UISwipeGestureRecognizerDirectionUp",
                                                @"UISwipeGestureRecognizerDirectionDown", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiModalPresentationStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIModalPresentationFullScreen",
                                                @"UIModalPresentationPageSheet",
                                                @"UIModalPresentationFormSheet",
                                                @"UIModalPresentationCurrentContext", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)uiModalTransitionStyleString {
    NSArray *values = [NSArray arrayWithObjects:@"UIModalTransitionStyleCoverVertical",
                                                @"UIModalTransitionStyleFlipHorizontal",
                                                @"UIModalTransitionStyleCrossDissolve",
                                                @"UIModalTransitionStylePartialCurl", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)glkDrawableColorFormatString {
    NSArray *values = [NSArray arrayWithObjects:@"GLKViewDrawableColorFormatRGBA8888",
                                                @"GLKViewDrawableColorFormatRGB565", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)glkDrawableDepthFormatString {
    NSArray *values = [NSArray arrayWithObjects:@"GLKViewDrawableDepthFormatNone",
                                                @"GLKViewDrawableDepthFormat16",
                                                @"GLKViewDrawableDepthFormat24", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)glkDrawableMultisampleString {
    NSArray *values = [NSArray arrayWithObjects:@"GLKViewDrawableMultisampleNone",
                                                @"GLKViewDrawableMultisample4X", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

- (NSString *)glkDrawableStencilFormatString {
    NSArray *values = [NSArray arrayWithObjects:@"GLKViewDrawableStencilFormatNone",
                                                @"GLKViewDrawableStencilFormatNone", nil];
    return [values objectAtIndex:[self unsignedIntValue]];
}

@end
