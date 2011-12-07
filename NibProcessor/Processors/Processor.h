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

+ (NSString*)processedClassName;
- (NSString*)getProcessedClassName;
+ (void)registerProcessor:(Processor*)processor;
+ (void)registerProcessor:(Processor*)processor forName:(NSString*)className;
+ (void)registerProcessorClass:(Class)processorClass;
+ (void)registerProcessorClass:(Class)processorClass forName:(NSString*)className;

+ (Processor *)processorForClass:(NSString *)klass;

- (NSDictionary *)processObject:(NSDictionary *)object;
- (void)processKey:(id)item value:(id)value;
- (NSString *)frameString;

@end


#define RegisterOnLoad                                                                              \
+(void)load                                                                                         \
{                                                                                                   \
    static dispatch_once_t onceToken;                                                               \
    dispatch_once(&onceToken, ^{                                                                    \
        [self registerProcessorClass:self];                                                         \
    });                                                                                             \
}

#define RegisterOnLoadWithIB                                                                        \
+(void)load                                                                                         \
{                                                                                                   \
    static dispatch_once_t onceToken;                                                               \
    dispatch_once(&onceToken, ^{                                                                    \
        [self registerProcessorClass:self];                                                         \
        [self registerProcessorClass:self                                                           \
                             forName:[@"IB" stringByAppendingString:[self processedClassName]]];    \
    });                                                                                             \
}

#define RegisterOnLoadWithCustom(customName)                                                        \
+(void)load                                                                                         \
{                                                                                                   \
    static dispatch_once_t onceToken;                                                               \
    dispatch_once(&onceToken, ^{                                                                    \
        [self registerProcessorClass:self];                                                         \
        [self registerProcessorClass:self forName:@customName];                                     \
    });                                                                                             \
}


