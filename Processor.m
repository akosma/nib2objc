//
//  Processor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Processor.h"

@interface Processor (Private)

- (void)getDictionaryFromNIB;
- (void)process;

@end


@implementation Processor

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
    [output release];
    output = [[NSMutableString alloc] init];
    //    NSDictionary *classes = [dict objectForKey:@"com.apple.ibtool.document.classes"];
    //    NSDictionary *connections = [dict objectForKey:@"com.apple.ibtool.document.connections"];
    //    NSArray *hierarchy = [dict objectForKey:@"com.apple.ibtool.document.hierarchy"];
    NSDictionary *objects = [dictionary objectForKey:@"com.apple.ibtool.document.objects"];
    
    for (NSDictionary *key in objects)
    {
        id object = [objects objectForKey:key];
        NSString *klass = [[object objectForKey:@"class"] stringByReplacingOccurrencesOfString:@"IB" 
                                                                                    withString:@""];
        [output appendFormat:@"%@ *instance = [[%@ alloc] init];\n", klass, klass];
        for (id item in object)
        {
            id value = [object objectForKey:item];
            if ([value isKindOfClass:[NSNumber class]])
            {
                [output appendFormat:@"instance.%@ = %@;\n", item, value];
            }
            else if ([value isKindOfClass:[NSString class]])
            {
                [output appendFormat:@"instance.%@ = @\"%@\";\n", item, value];
            }
        }
        
        [output appendString:@"\n"];
    }
}

@end
