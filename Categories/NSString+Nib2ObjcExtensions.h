//
//  NSString+Nib2ObjcExtensions.h
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSString (Nib2ObjcExtensions)

+ (NSString *)rectStringFromPoint:(NSString *)pointString size:(NSString *)sizeString;
- (NSString *)sizeString;
- (NSString *)colorString;
- (NSString *)quotedAsCodeString;

@end
