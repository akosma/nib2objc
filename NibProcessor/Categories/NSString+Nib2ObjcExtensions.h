//
//  NSString+Nib2ObjcExtensions.h
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

@interface NSString (Nib2ObjcExtensions)

+ (NSString *)cgRectStringFromPoint:(NSString *)pointString size:(NSString *)sizeString;

+ (NSString *)dateFromStringFunction;

- (NSString *)cgSizeString;

- (NSString *)uiColorString;

- (NSString *)quotedAsCodeString;

- (NSString *)capitalize;

@end
