//
//  NibProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NibProcessor.h"
#import "UIViewProcessor.h"
#import "UITextFieldProcessor.h"
#import "UIProgressViewProcessor.h"
#import "UISwitchProcessor.h"
#import "UISliderProcessor.h"

static Class getProcessorClass(NSString *className)
{
    Class returnClass = [NSNull class];
    if ([className isEqualToString:@"IBUIView"])
    {
        returnClass = [UIViewProcessor class];
    }
    else if ([className isEqualToString:@"IBUITextField"])
    {
        returnClass = [UITextFieldProcessor class];
    }
    else if ([className isEqualToString:@"IBUIProgressView"])
    {
        returnClass = [UIProgressViewProcessor class];
    }
    else if ([className isEqualToString:@"IBUISwitch"])
    {
        returnClass = [UISwitchProcessor class];
    }
    else if ([className isEqualToString:@"IBUISlider"])
    {
        returnClass = [UISliderProcessor class];
    }
    return returnClass;
}

@interface NibProcessor (Private)

- (void)getDictionaryFromNIB;
- (void)process;

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
    //    NSArray *nibHierarchy = [dict objectForKey:@"com.apple.ibtool.document.hierarchy"];
    NSDictionary *nibObjects = [dictionary objectForKey:@"com.apple.ibtool.document.objects"];
    NSMutableDictionary *objects = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *key in nibObjects)
    {
        id object = [nibObjects objectForKey:key];
        NSString *klass = [object objectForKey:@"class"];

        Class processorClass = getProcessorClass(klass);
        if ([processorClass isEqual:[NSNull class]])
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:klass forKey:@"unknown object (yet)"];
            [objects setObject:dict forKey:key];
        }
        else
        {
            UIViewProcessor *processor = [[processorClass alloc] init];
            processor.instanceName = @"instance";
            NSDictionary *dict = [processor processObject:object];
            [objects setObject:dict forKey:key];
            [processor release];
        }
    }
    
    [output release];
    output = [[NSMutableString alloc] init];
    for (NSDictionary *identifier in objects)
    {
        id object = [objects objectForKey:identifier];
        
        for (NSString *key in object)
        {
            id value = [object objectForKey:key];
            [output appendFormat:@"%@ = %@;\n", key, value];

//            if (![value isEqualToString:@"NULL"])
//            {
//                [output appendFormat:@"%@ = %@;\n", key, value];
//            }
        }
        [output appendString:@"\n"];    
    }
    
    [objects release];
    objects = nil;
}

@end
