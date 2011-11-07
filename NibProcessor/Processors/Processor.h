//
//  Processor.h
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

@interface Processor : NSObject 
{
@protected
    NSMutableDictionary *output;
@private
    NSDictionary *input;
    NSSet *ignoredProperties;
}

@property (nonatomic, readonly) NSDictionary *input;

+ (Processor *)processorForClass:(NSString *)klass;

- (NSDictionary *)processObject:(NSDictionary *)object;
- (void)processKey:(id)item value:(id)value;
- (NSString *)frameString;

@end
