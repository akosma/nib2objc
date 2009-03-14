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
    NSDictionary *dict;
    NSMutableString *output;
    NSString *instanceName;
}

@property (nonatomic, retain) NSString *instanceName;

- (void)processDictionary:(NSDictionary *)dictionary into:(NSMutableString *)outputString;
- (NSString *)rectFromPoint:(NSString *)pointString size:(NSString *)sizeString;
- (NSString *)colorFromValue:(NSString *)colorString;
- (NSString *)contentModeFromValue:(NSNumber *)contentMode;
- (NSString *)booleanFromValue:(NSNumber *)boolean;

@end
