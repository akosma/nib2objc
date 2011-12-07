//
//  Processor.m
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import "Processor.h"


@interface Processor ()
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
    NSLog(@"registerProcessorClass: %@ forName: %@", processorClass, className);
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
                                     reason:@"_ProcessorRegistry isn't meant to be instantiated"
                                   userInfo:nil] autorelease];
    @throw exception;
}

@end

#pragma mark -


@implementation Processor

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

    NSLog(@"processor class: %@  default processed class: %@", processorClassName, className);

    return [className autorelease];
}

- (NSString *)getProcessedClassName {
    return [[self class] processedClassName];
}

+ (void)registerProcessor:(Processor *)processor {
    [ProcessorRegistry registerProcessorClass:[processor class]];
}

+ (void)registerProcessor:(Processor *)processor forName:(NSString *)className {
    [ProcessorRegistry registerProcessorClass:[processor class] forName:className];
}

+ (void)registerProcessorClass:(Class)processorClass {
    [ProcessorRegistry registerProcessorClass:processorClass];
}

+ (void)registerProcessorClass:(Class)processorClass forName:(NSString *)className {
    [ProcessorRegistry registerProcessorClass:processorClass forName:className];
}

+ (Processor *)processorForClass:(NSString *)klass {
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

- (void)processKey:(id)item value:(id)value {
#pragma unused(item)
#pragma unused(value)
    // Overridden in subclasses
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
