//
//  main.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#include <stdio.h>
#import <Foundation/Foundation.h>
#include "NibProcessor.h"

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Verify that we have the required number of parameters in the command line
        if (argc < 2)
        {
            printf("This utility requires a valid NIB file path as parameter.\n");
            return 0;
        }
        
        // Test that the input file exists, and that it is not a directory
        NSString *nibFile = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL fileExists = [manager fileExistsAtPath:nibFile isDirectory:&isDirectory];
        if (!fileExists || isDirectory)
        {
            printf("This utility requires a valid NIB file path as parameter.\n");
            return 0;
        }
        
        // As an optional second parameter, specify whether to use properties or setters
        NibProcessorCodeStyle codeStyle = NibProcessorCodeStyleProperties;
        
        if (argc > 2)
        {
            int value = atoi(argv[2]);
            
            if (value == 1 || value == 2)
            {
                codeStyle = (NibProcessorCodeStyle)value;
            }
        }
        
        // Use a Processor instance to generate the source code file 
        // and redirect the output to the standard output stream
        NibProcessor *processor = [[NibProcessor alloc] init];
        processor.codeStyle = codeStyle;
        processor.input = nibFile;
        [processor process];
        printf([processor.output UTF8String], NULL);
        [processor release];
        
    }
    return 0;
}

