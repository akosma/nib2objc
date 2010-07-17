//
//  MyDocument.h
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
@private
    NSTextView *_editor;
    NSString *_nibCode;
    NSString *_fileName;
}

@property (nonatomic, retain) IBOutlet NSTextView *editor;

@end
