#include <stdio.h>
#import <Foundation/Foundation.h>
#include "Processor.h"

// Call this program using "build/Debug/nib2objc TestViewController.xib Output.m" during development.
int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // Verify that we have the required number of parameters in the command line
    if (argc != 2)
    {
        printf("This utility requires a valid NIB file path as parameter.\n");
        [pool drain];
        return 0;
    }
    
    // Test that the input file exists, and that it is not a directory
    NSString *nibFile = [NSString stringWithCString:argv[1]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL fileExists = [manager fileExistsAtPath:nibFile isDirectory:&isDirectory];
    if (!fileExists || isDirectory)
    {
        printf("This utility requires a valid NIB file path as parameter.\n");
        [pool drain];
        return 0;
    }

    // Use a Processor instance to generate the source code file 
    // and redirect the output to the standard output stream
    Processor *processor = [[Processor alloc] init];
    processor.input = nibFile;
    printf([processor.output UTF8String]);
    [processor release];

    [pool drain];
    return 0;
}
