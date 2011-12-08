//
//  Processor.h
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

@interface ObjectProcessor : NSObject {
@protected
    NSMutableDictionary *output;
@private
    NSDictionary *input;
    NSSet *ignoredProperties;
}

@property(nonatomic, readonly) NSDictionary *input;

+ (NSString *)processedClassName;

- (NSString *)getProcessedClassName;

+ (void)registerProcessor:(ObjectProcessor *)processor;

+ (void)registerProcessor:(ObjectProcessor *)processor forName:(NSString *)className;

+ (void)registerProcessorClass:(Class)processorClass;

+ (void)registerProcessorClass:(Class)processorClass forName:(NSString *)className;

+ (ObjectProcessor *)processorForClass:(NSString *)klass;

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
        [self registerProcessorClass:self forName:customName];                                      \
    });                                                                                             \
}


#define KeyExpressionMethodMeta(type, keyName, expression)                                          \
    type (NSString *) keyName ## String:(id) __attribute__((unused)) value                          \
    { return expression; }

#define KeyExpressionClassMethod(keyName, expression)                                               \
    KeyExpressionMethodMeta(+, keyName, expression)

#define KeyExpressionInstanceMethod(keyName, expression)                                            \
    KeyExpressionMethodMeta(-, keyName, expression)

#define KeyExpressionMethod(keyName, expression)                                                    \
    KeyExpressionClassMethod(keyName, expression)

#define KeyValueMethod(keyName, methodName)                                                         \
    KeyExpressionMethod(keyName, [value methodName])

#define BooleanKey(keyName)             KeyValueMethod(keyName, booleanString)
#define FloatKey(keyName)               KeyValueMethod(keyName, floatString)
#define IntKey(keyName)                 KeyValueMethod(keyName, intString)
#define QuotedKey(keyName)              KeyValueMethod(keyName, quotedAsCodeString)
