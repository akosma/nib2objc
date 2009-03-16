//
//  Processor.h
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UIViewProcessor;

@interface Processor : NSObject 
{
@protected
    NSMutableDictionary *output;
@private
    NSDictionary *input;
}

@property (nonatomic, readonly) NSDictionary *input;

+ (UIViewProcessor *)processorForClass:(NSString *)klass;

- (NSDictionary *)processObject:(NSDictionary *)object;
- (void)processKey:(id)item value:(id)value;
- (NSString *)frameString;


@end
