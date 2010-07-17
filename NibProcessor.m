//
//  NibProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Adrian Kosmaczewski 2009
//

#import "NibProcessor.h"
#import "Processor.h"

@interface NibProcessor (Private)

- (void)getDictionaryFromNIB;
- (void)process;
- (void)parseChildren:(NSDictionary *)dict ofCurrentView:(int)currentView;

@end


@implementation NibProcessor

@dynamic input;
@synthesize output;

- (void)dealloc
{
    [filename release];
    [output release];
    [dictionary release];
    [data release];
    [super dealloc];
}

#pragma mark -
#pragma mark Properties

- (NSString *)input
{
    return filename;
}

- (void)setInput:(NSString *)newFilename
{
    [filename release];
    filename = nil;
    filename = [newFilename copy];
    [self getDictionaryFromNIB];
    [self process];
}

- (NSString *)inputAsText
{
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

- (NSDictionary *)inputAsDictionary
{
    NSString *errorStr = nil;
    NSPropertyListFormat format;
    NSDictionary *propertyList = [NSPropertyListSerialization propertyListFromData:data
                                                                  mutabilityOption:NSPropertyListImmutable
                                                                            format:&format
                                                                  errorDescription:&errorStr];
    [errorStr release];
    return propertyList;    
}

#pragma mark -
#pragma mark Private methods

- (void)getDictionaryFromNIB
{
    // Build the NSTask that will run the ibtool utility
    NSArray *arguments = [NSArray arrayWithObjects:filename, @"--objects", 
                          @"--hierarchy", @"--connections", @"--classes", nil];
    NSTask *task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *readHandle = [pipe fileHandleForReading];
    NSData *temp = nil;

    [data release];
    data = [[NSMutableData alloc] init];
    
    [task setLaunchPath:@"/usr/bin/ibtool"];
    [task setArguments:arguments];
    [task setStandardOutput:pipe];
    [task launch];
    
    while ((temp = [readHandle availableData]) && [temp length]) 
    {
        [data appendData:temp];
    }

    // This dictionary is ready to be parsed, and it contains
    // everything we need from the NIB file.
    dictionary = [[self inputAsDictionary] retain];
    
    [task release];
}

- (void)process
{
    //    NSDictionary *nibClasses = [dict objectForKey:@"com.apple.ibtool.document.classes"];
    //    NSDictionary *nibConnections = [dict objectForKey:@"com.apple.ibtool.document.connections"];
    NSDictionary *nibObjects = [dictionary objectForKey:@"com.apple.ibtool.document.objects"];
    NSMutableDictionary *objects = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *key in nibObjects)
    {
        id object = [nibObjects objectForKey:key];
        NSString *klass = [object objectForKey:@"class"];

        Processor *processor = [Processor processorForClass:klass];

        if (processor == nil)
        {
#ifdef CONFIGURATION_Debug
            // Get notified about classes not yet handled by this utility
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:klass forKey:@"// unknown object (yet)"];
            [objects setObject:dict forKey:key];
            [dict release];
#endif
        }
        else
        {
            NSDictionary *dict = [processor processObject:object];
            [objects setObject:dict forKey:key];
        }
    }
    
    // Let's print everything as source code
    [output release];
    output = [[NSMutableString alloc] init];
    for (NSDictionary *identifier in objects)
    {
        id object = [objects objectForKey:identifier];
        
        // First, output any helper functions, ordered alphabetically
        NSArray *orderedKeys = [object keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *key in orderedKeys)
        {
            id value = [object objectForKey:key];
            if ([key hasPrefix:@"__helper__"])
            {
                [output appendString:value];
                [output appendString:@"\n"];    
            }
        }
        
        // Then, output the constructor and the frame
        id klass = [object objectForKey:@"class"];
        id constructor = [object objectForKey:@"constructor"];
        id frame = [object objectForKey:@"frame"];
        [output appendFormat:@"%@ *view%@ = %@;\n", klass, identifier, constructor];
        [output appendFormat:@"view%@.frame = %@;\n", identifier, frame];
        
        // Then, output the properties only, ordered alphabetically
        orderedKeys = [[object allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *key in orderedKeys)
        {
            id value = [object objectForKey:key];
            if (![key hasPrefix:@"__method__"] && ![key isEqualToString:@"frame"] 
                && ![key isEqualToString:@"constructor"] && ![key isEqualToString:@"class"]
                && ![key hasPrefix:@"__helper__"])
            {
                [output appendFormat:@"view%@.%@ = %@;\n", identifier, key, value];
            }
        }

        // Finally, output the method calls, ordered alphabetically
        orderedKeys = [object keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *key in orderedKeys)
        {
            id value = [object objectForKey:key];
            if ([key hasPrefix:@"__method__"])
            {
                [output appendFormat:@"[view%@ %@];\n", identifier, value];
            }
        }
        [output appendString:@"\n"];    
    }
    
    // Now that the objects are created, recreate the hierarchy of the NIB
    NSArray *nibHierarchy = [dictionary objectForKey:@"com.apple.ibtool.document.hierarchy"];
    for (NSDictionary *item in nibHierarchy)
    {
        int currentView = [[item objectForKey:@"object-id"] intValue];
        [self parseChildren:item ofCurrentView:currentView];
    }
    
    [objects release];
    objects = nil;
}

- (void)parseChildren:(NSDictionary *)dict ofCurrentView:(int)currentView
{
    NSArray *children = [dict objectForKey:@"children"];
    if (children != nil)
    {
        for (NSDictionary *subitem in children)
        {
            int subview = [[subitem objectForKey:@"object-id"] intValue];
            [self parseChildren:subitem ofCurrentView:subview];
            [output appendFormat:@"[view%d addSubview:view%d];\n", currentView, subview];
        }
    }
}

@end
