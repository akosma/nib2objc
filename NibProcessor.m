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
#import "UILabelProcessor.h"
#import "UIActivityIndicatorViewProcessor.h"
#import "UIPageControlProcessor.h"
#import "UIButtonProcessor.h"
#import "UISegmentedControlProcessor.h"

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

        UIViewProcessor *processor = nil;
        
        if ([klass isEqualToString:@"IBUIView"]) processor = [[UIViewProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUITextField"]) processor = [[UITextFieldProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUIProgressView"]) processor = [[UIProgressViewProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUISwitch"]) processor = [[UISwitchProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUISlider"]) processor = [[UISliderProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUILabel"]) processor = [[UILabelProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUIActivityIndicatorView"]) processor = [[UIActivityIndicatorViewProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUIPageControl"]) processor = [[UIPageControlProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUIButton"]) processor = [[UIButtonProcessor alloc] init];
        else if ([klass isEqualToString:@"IBUISegmentedControl"]) processor = [[UISegmentedControlProcessor alloc] init];

        if (processor == nil)
        {
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//            [dict setObject:klass forKey:@"// unknown object (yet)"];
//            [objects setObject:dict forKey:key];
//            [dict release];
        }
        else
        {
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
            if ([key hasPrefix:@"__method__"])
            {
                [output appendFormat:@"[instance_%@ %@];\n", identifier, value];
            }
            else
            {
                [output appendFormat:@"instance_%@.%@ = %@;\n", identifier, key, value];
            }
        }
        [output appendString:@"\n"];    
    }
    
    [objects release];
    objects = nil;
}

@end
