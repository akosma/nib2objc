//
//  NSNumber+Nib2ObjcExtensions.h
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>


@interface NSNumber (Nib2ObjcExtensions)

- (NSString *)booleanString;
- (NSString *)intString;
- (NSString *)floatString;
- (NSString *)autoresizingMaskString;
- (NSString *)contentModeString;
- (NSString *)textAlignmentString;
- (NSString *)borderStyleString;
- (NSString *)contentHorizontalAlignmentString;
- (NSString *)contentVerticalAlignmentString;
- (NSString *)keyboardAppearanceString;
- (NSString *)returnKeyTypeString;
- (NSString *)autocapitalizationTypeString;
- (NSString *)autocorrectionTypeString;
- (NSString *)keyboardTypeString;
- (NSString *)progressViewStyleString;
- (NSString *)baselineAdjustmentString;
- (NSString *)lineBreakModeString;
- (NSString *)activityIndicatorViewStyleString;
- (NSString *)buttonTypeString;
- (NSString *)segmentedControlStyleString;
- (NSString *)scrollViewIndicatorStyleString;
- (NSString *)tableViewStyleString;
- (NSString *)tableViewCellSeparatorStyleString;
- (NSString *)tableViewCellAccessoryString;
- (NSString *)tableViewCellEditingStyleString;
- (NSString *)tableViewCellSelectionStyleString;
- (NSString *)datePickerModeString;
- (NSString *)barStyleString;
- (NSString *)barButtonItemStyleString;
- (NSString *)barButtonSystemItemString;
- (NSString *)tabBarSystemItemString;
- (NSString *)mapTypeString;
- (NSString *)clearButtonModeString;
- (NSString *)swipeGestureRecognizerDirectionString;
- (NSString *)modalPresentationStyleString;
- (NSString *)modalTransitionStyleString;
- (NSString *)drawableColorFormatString;
- (NSString *)drawableDepthFormatString;
- (NSString *)drawableMultisampleString;
- (NSString *)drawableStencilFormatString;

@end
