//
//  Processor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Processor.h"

NSString *processDictionary(NSDictionary *dict)
{
    NSMutableString *output = [[NSMutableString alloc] init];
    //    NSDictionary *classes = [dict objectForKey:@"com.apple.ibtool.document.classes"];
    //    NSDictionary *connections = [dict objectForKey:@"com.apple.ibtool.document.connections"];
    //    NSArray *hierarchy = [dict objectForKey:@"com.apple.ibtool.document.hierarchy"];
    NSDictionary *objects = [dict objectForKey:@"com.apple.ibtool.document.objects"];
    
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
    
    return output;
}

NSDictionary *getPropertyList(NSData *data)
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

NSString *getText(NSData *data)
{
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

NSDictionary *getDictionaryFromNIB(NSString *nibFile)
{
    // Build the NSTask that will run the ibtool utility
    NSArray *arguments = [NSArray arrayWithObjects:nibFile, @"--objects", 
                          @"--hierarchy", @"--connections", @"--classes", nil];
    NSTask *task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *readHandle = [pipe fileHandleForReading];
    NSData *data = nil;
    NSMutableData *output = [[NSMutableData alloc] init];
    
    [task setLaunchPath:@"/usr/bin/ibtool"];
    [task setArguments:arguments];
    [task setStandardOutput:pipe];
    [task launch];
    
    while ((data = [readHandle availableData]) && [data length]) 
    {
        [output appendData:data];
    }
    
    //    NSLog(getText(output));
    
    // This dictionary is ready to be parsed, and it contains
    // everything we need from the NIB file.
    NSDictionary *dict = getPropertyList(output);
    
    [output release];
    [task release];
    
    return dict;
}
