#include <stdio.h>
#import <Foundation/Foundation.h>
#include "Processor.h"

// Call this program using "build/Debug/nib2objc TestViewController.xib Output.m" during development.
int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // Verify that we have the required number of parameters in the command line
    if (argc != 3)
    {
        printf("This utility requires a valid NIB file path as first parameter, and an output file name as second parameter.\n");
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
        return 0;
    }

    // Test that the output file does not exist
    NSString *outputFile = [NSString stringWithCString:argv[2]];
    fileExists = [manager fileExistsAtPath:outputFile];
    if (fileExists)
    {
        printf("The output file already exists! Please select another name for the output file.\n");
        return 0;
    }
    
    // Read the input NIB file and create an NSDictionary
    NSDictionary *dict = getDictionaryFromNIB(nibFile);
    
    // Process the NSDictionary and generate the output file
    NSString *contents = processDictionary(dict);
    
    // Save the output file to disk
    NSError *error = nil;
    [contents writeToFile:outputFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    [error release];

    [pool drain];
    return 0;
}
