//
//  NSWindowTemplateProcessor.h
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "Processor.h"

@interface NSWindowTemplateProcessor : Processor

- (NSString *)backingTypeString:(id)value;
- (NSString *)sizeString:(id)value;
- (NSString *)styleMaskString:(id)value;

@end
