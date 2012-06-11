//
//  NSViewProcessor.h
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "Processor.h"

@interface NSViewProcessor : Processor

- (NSString *)autoresizingMaskString:(id)value;
- (NSString *)borderTypeString:(id)value;
- (NSString *)colorString:(id)value;
- (NSString *)floatString:(id)value;
- (NSString *)focusRingTypeString:(id)value;
- (NSString *)fontString:(id)value;
- (NSString *)sizeString:(id)value;

- (NSString *)checkString:(NSString *)aString key:(id)item value:(id)value;

@end
