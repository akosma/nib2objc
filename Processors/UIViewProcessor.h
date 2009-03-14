//
//  UIViewProcessor.h
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UIViewProcessor : NSObject 
{
@protected
    NSString *klass;
    NSMutableString *output;
    NSString *instanceName;
    NSDictionary *dict;
}

@property (nonatomic, retain) NSString *instanceName;

- (void)processDictionary:(NSDictionary *)dictionary into:(NSMutableString *)outputString;

- (void)processUnknownProperty:(id)item value:(id)value;

- (NSString *)rectFromPoint:(NSString *)pointString size:(NSString *)sizeString;
- (NSString *)colorFromValue:(NSString *)colorString;
- (NSString *)contentModeFromValue:(NSNumber *)contentMode;
- (NSString *)booleanFromValue:(NSNumber *)boolean;
- (NSString *)autoresizingMaskFromValue:(NSNumber *)autoresizingMask;
- (NSString *)textAlignmentFromValue:(NSNumber *)textAlignment;
- (NSString *)fontFromValue:(NSDictionary *)font;
- (NSString *)borderStyleFromValue:(NSNumber *)borderStyle;
- (NSString *)contentHorizontalAlignmentForValue:(NSNumber *)contentHorizontalAlignment;
- (NSString *)contentVerticalAlignmentForValue:(NSNumber *)contentVerticalAlignment;

@end
