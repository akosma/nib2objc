#include <stdio.h>
#import <Foundation/Foundation.h>
#include "NibProcessor.h"

// Call this program using "build/Debug/nib2objc TestViewController.xib" during development.
int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // Verify that we have the required number of parameters in the command line
    if (argc < 2)
    {
        printf("This utility requires a valid NIB file path as parameter.\n");
        [pool drain];
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
        [pool drain];
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

    [pool drain];
    return 0;
}
