//
//  NSButtonCellProcessor.h
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSCellProcessor.h"

@interface NSButtonCellProcessor : NSCellProcessor

- (NSString *)bezelStyleString:(id)value;
- (NSString *)buttonTypeString:(id)value;
- (NSString *)imagePositionString:(id)value;
- (NSString *)keyEquivalentModifierMaskString:(id)value;

@end
