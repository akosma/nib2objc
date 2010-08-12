//
//  NSString+Nib2ObjcExtensions.h
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

@interface NSString (Nib2ObjcExtensions)

+ (NSString *)rectStringFromPoint:(NSString *)pointString size:(NSString *)sizeString;
+ (NSString *)dateFromStringFunction;
- (NSString *)sizeString;
- (NSString *)colorString;
- (NSString *)quotedAsCodeString;
- (NSString *)capitalize;

@end
