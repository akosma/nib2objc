//
//  MyDocument.h
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class MGSFragaria;

@interface MyDocument : NSDocument
{
@private
    NSView *_editorView;
    NSString *_nibCode;
    NSString *_fileName;
	MGSFragaria *_fragariaEditor;
}

@property (nonatomic, retain) IBOutlet NSView *editorView;

@end
