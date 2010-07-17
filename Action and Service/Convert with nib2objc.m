//
//  Convert with nib2objc.m
//  Convert with nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright (c) 2010 __MyCompanyName__, All Rights Reserved.
//

#import "Convert with nib2objc.h"
#import "NibProcessor.h"

@implementation Convert_with_nib2objc

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    // Use a Processor instance to generate the source code file 
    // and redirect the output to the standard output stream
    // Important: in the context of animator services, "input" 
    // is an array with string filenames.
    NibProcessor *processor = [[[NibProcessor alloc] init] autorelease];
    processor.input = [input objectAtIndex:0];
	return processor.output;
}

@end
