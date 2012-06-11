//
//  NSCellProcessor.h
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSViewProcessor.h"

@interface NSCellProcessor : NSViewProcessor

- (NSString *)alignmentString:(id)value;
- (NSString *)baseWritingDirectionString:(id)value;
- (NSString *)controlSizeString:(id)value;
- (NSString *)imageScalingString:(id)value;
- (NSString *)lineBreakModeString:(id)value;
- (NSString *)stateString:(id)value;

@end
