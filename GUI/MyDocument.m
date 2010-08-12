//
//  MyDocument.m
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyDocument.h"
#import "NibProcessor.h"
#import <MGSFragaria/MGSFragaria.h>

@interface MyDocument ()

@property (nonatomic, copy) NSString *nibCode;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, retain) MGSFragaria *fragariaEditor;
@property (nonatomic, retain) NibProcessor *nibProcessor;

@end



@implementation MyDocument

@synthesize editorView = _editorView;
@synthesize nibCode = _nibCode;
@synthesize fileName = _fileName;
@synthesize fragariaEditor = _fragariaEditor;
@synthesize nibProcessor = _nibProcessor;
@synthesize radioButtonMatrix = _radioButtonMatrix;

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)dealloc
{
    [_editorView release];
    _editorView = nil;
    [_nibCode release];
    _nibCode = nil;
    [_fileName release];
    _fileName = nil;
    [_fragariaEditor release];
    _fragariaEditor = nil;
    [_nibProcessor release];
    _nibProcessor = nil;
    [_radioButtonMatrix release];
    _radioButtonMatrix = nil;
    
    [super dealloc];
}

- (NSString *)windowNibName
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    self.fragariaEditor = [[[MGSFragaria alloc] init] autorelease];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:MGSPrefsAutocompleteSuggestAutomatically];	
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:MGSPrefsLineWrapNewDocuments];	
    [self.fragariaEditor setObject:[NSNumber numberWithBool:YES] forKey:MGSFOIsSyntaxColoured];
    [self.fragariaEditor setObject:[NSNumber numberWithBool:YES] forKey:MGSFOShowLineNumberGutter];
    [self.fragariaEditor setObject:@"Objective-C" forKey:MGSFOSyntaxDefinitionName];
    [self.fragariaEditor embedInView:self.editorView];
    [self.fragariaEditor setString:self.nibCode];
    
    NSTextView *textView = [self.fragariaEditor objectForKey:ro_MGSFOTextView];
    [textView setEditable:NO];
    [textView setFont:[NSFont fontWithName:@"Monaco" size:14.0]];
}

- (BOOL)prepareSavePanel:(NSSavePanel *)savePanel
{
    [savePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"m", nil]];
    [savePanel setExtensionHidden:NO];
    return YES;
}

- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
    [self.nibCode writeToURL:absoluteURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return YES;
}

- (BOOL)readFromFile:(NSString *)fileName ofType:(NSString *)type
{
    self.fileName = fileName;
    self.nibProcessor = [[[NibProcessor alloc] init] autorelease];
    self.nibProcessor.input = self.fileName;
    [self.nibProcessor process];
    self.nibCode = self.nibProcessor.output;
    return YES;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)changeOutputType:(id)sender
{
    self.nibProcessor.codeStyle = (NibProcessorCodeStyle)[self.radioButtonMatrix selectedTag];
    [self.nibProcessor process];
    self.nibCode = self.nibProcessor.output;
    [self.fragariaEditor setString:@""];
    [self.fragariaEditor setString:self.nibCode];
}

@end
