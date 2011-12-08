//
//  Processor.m
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import "ObjectProcessor.h"


@interface ObjectProcessor ()
+ (NSString *)processedClassName;

- (NSString *)getProcessedClassName;

- (NSString *)constructorString;
@end


#pragma mark private processor registry

@interface ProcessorRegistry : NSObject
+ (NSMutableDictionary *)mutableMap;

+ (NSDictionary *)map;

+ (Class)processorClassForName:(NSString *)className;

+ (void)registerProcessorClass:(Class)processorClass;

+ (void)registerProcessorClass:(Class)processorClass forName:(NSString *)className;
@end

@implementation ProcessorRegistry

+ (NSMutableDictionary *)mutableMap {
    static __strong NSMutableDictionary *_processorMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _processorMap = [[NSMutableDictionary alloc] init];
    });
    return _processorMap;
}

+ (NSDictionary *)map {
    return [[[self mutableMap] copy] autorelease];
}

+ (Class)processorClassForName:(NSString *)className {
    return [[self map] valueForKey:className];
}

+ (void)registerProcessorClass:(Class)processorClass
                       forName:(NSString *)className {
    [[self mutableMap] setValue:processorClass
                         forKey:className];
}

+ (void)registerProcessorClass:(Class)processorClass {
    [self registerProcessorClass:processorClass
                         forName:[processorClass processedClassName]];
}

- (id)init {
    [self release];
    NSException *exception =
            [[NSException exceptionWithName:NSGenericException
                                     reason:@"ProcessorRegistry isn't meant to be instantiated"
                                   userInfo:nil] autorelease];
    @throw exception;
}

@end

#pragma mark -


@implementation ObjectProcessor

@synthesize input;

#pragma mark registry

+ (NSString *)processedClassName {
    NSString *className;
    NSString *processorClassName = [NSStringFromClass(self) autorelease];
    NSRange suffix = [processorClassName rangeOfString:@"Processor"
                                               options:(NSBackwardsSearch | NSAnchoredSearch | NSLiteralSearch)];
    if (suffix.length == 0) {
        NSException *autoNameException =
                [NSException exceptionWithName:NSGenericException
                                        reason:@"Please implement +(NSString*)processedClassName in your processor subclass."
                                      userInfo:nil];
        @throw autoNameException;
    } else {
        className = [processorClassName substringToIndex:suffix.location];
    }

    return className;
}

- (NSString *)getProcessedClassName {
    return [[self class] processedClassName];
}

+ (void)registerProcessor:(ObjectProcessor *)processor {
    [ProcessorRegistry registerProcessorClass:[processor class]];
}

+ (void)registerProcessor:(ObjectProcessor *)processor forName:(NSString *)className {
    [ProcessorRegistry registerProcessorClass:[processor class] forName:className];
}

+ (void)registerProcessorClass:(Class)processorClass {
    [ProcessorRegistry registerProcessorClass:processorClass];
}

+ (void)registerProcessorClass:(Class)processorClass forName:(NSString *)className {
    [ProcessorRegistry registerProcessorClass:processorClass forName:className];
}

+ (ObjectProcessor *)processorForClass:(NSString *)klass {
    Class processorClass = [ProcessorRegistry processorClassForName:klass];
    return [[[processorClass alloc] init] autorelease];
}

#pragma mark -

- (id)init {
    self = [super init];
    if (self) {
        ignoredProperties = [[NSSet alloc] initWithObjects:@"ibExternalIdentityShowNotesWithSelection",
                                                           @"systemItemIdentifier",
                                                           @"autoresizesSubviewsForDevice",
                                                           @"backgroundFilters",
                                                           @"canDrawConcurrently",
                                                           @"clipsSubviews",
                                                           @"contentFilters",
                                                           @"focusRingType",
                                                           @"frameCenterRotation",
                                                           @"alphaValue",
                                                           @"frameOrigin",
                                                           @"frameSize",
                                                           @"ibExternalTranslatesAutoresizingMaskIntoConstraints",
                                                           @"ibShadowedHorizontalContentCompressionResistancePriority",
                                                           @"ibShadowedHorizontalContentHuggingPriority",
                                                           @"ibShadowedVerticalContentCompressionResistancePriority",
                                                           @"ibShadowedVerticalContentHuggingPriority",
                                                           @"opaqueForDevice",
                                                           @"simulatedOrientationMetrics",
                                                           @"wantsLayer",
                                                           @"autoresizesArchivedViewToFullSize",
                                                           @"designatedEntryPoint",
                                                           @"simulatedStatusBarMetrics",
                                                           @"contentInset",
                                                           @"dataMode",
                                                           @"scrollIndicatorInsets",
                                                           @"showsSelectionImmediatelyOnTouchBegin",
                                                           @"ibExternalExplicitLabel",
                                                           @"fontDescription",
                                                           @"edgeInsetsContent",
                                                           @"edgeInsetsImage",
                                                           @"edgeInsetsTitle",
                                                           @"highlightedColor",
                                                           @"proxiedObjectIdentifier",
                                                           @"ibExternalCustomClassName", nil];
    }
    return self;
}

- (void)dealloc {
    [ignoredProperties release];
    [output release];
    [input release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public method

- (NSDictionary *)processObject:(NSDictionary *)object {
    input = [object retain];
    [output release];
    output = [[NSMutableDictionary alloc] init];

    for (id item in input) {
        id value = [input objectForKey:item];
        [self processKey:item value:value];

#if defined (DEBUG)
        // This will show properties not yet known by nib2objc
        if ([output objectForKey:item] == nil &&
                ![ignoredProperties containsObject:item]) {
            NSString *unknown = [NSString stringWithFormat:@"// unknown property: %@", value];
            [output setObject:unknown forKey:item];
        }
#endif
    }

    // Because of proxy objects, this call should be done at the end
    // when all the properties of the object have been parsed
    [output setObject:[self constructorString] forKey:@"constructor"];

    NSString *frameString = [self frameString];
    if (nil != frameString) {
        [output setObject:frameString forKey:@"frame"];
    }

    return output;
}

+ (NSString *)classString:(id)value {
#pragma unused (value)
    return [self processedClassName];
}

- (void)processKey:(id)item value:(id)value {
    if ([ignoredProperties containsObject:item]) return;
    
    id object = nil;
    
    NSString* method = [NSString stringWithFormat:@"%@String:", item];
    SEL selector = NSSelectorFromString(method);
    
    if ([[self class] respondsToSelector:selector]) {
        object = [[self class] performSelector:selector withObject:value];
    } else if ([self respondsToSelector:selector]) {
        object = [self performSelector:selector withObject:value];
    }
    
    if (object != nil) {
        [output setObject:object forKey:item];
    }
}

- (NSString *)frameString {
    return nil;
}

- (NSString *)constructorString {
    // Some subclasses have different constructors than the classic
    // "initWithFrame:", and as such they should override this method.
    return [NSString stringWithFormat:@"[[%@ alloc] init]", [self getProcessedClassName]];
}

@end
