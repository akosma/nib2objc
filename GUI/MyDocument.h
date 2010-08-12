//
//  MyDocument.h
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class MGSFragaria;
@class NibProcessor;

@interface MyDocument : NSDocument
{
@private
    NSView *_editorView;
    NSString *_nibCode;
    NSString *_fileName;
	MGSFragaria *_fragariaEditor;
    NibProcessor *_nibProcessor;
    NSMatrix *_radioButtonMatrix;
}

@property (nonatomic, retain) IBOutlet NSView *editorView;
@property (nonatomic, retain) IBOutlet NSMatrix *radioButtonMatrix;

- (IBAction)changeOutputType:(id)sender;

@end
