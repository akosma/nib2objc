//
//  AppDelegate.m
//  nib2objc
//
//  Created by Adrian on 7/18/10.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
#pragma unused (sender)
    return NO;
}

-(void)applicationWillFinishLaunching:(NSNotification *)notification
{
#pragma unused (notification)
#if defined (DEBUG) || defined (FSCRIPT)
    // load FScript if available for easy runtime introspection and debugging
    BOOL loaded = [[NSBundle bundleWithPath:@"/Library/Frameworks/FScript.framework"] load];
    if (loaded) {
        Class FScriptMenuItem = NSClassFromString(@"FScriptMenuItem");
        id fscMenuItem = [[[FScriptMenuItem alloc] init] autorelease];
        id fiv = [fscMenuItem performSelector:@selector(interpreterView)];
        id fi = [fiv performSelector:@selector(interpreter)];
        [fi performSelector:@selector(setObject:forIdentifier:) 
                 withObject:self 
                 withObject:@"appDelegate"];
        [fi performSelector:@selector(setObject:forIdentifier:) 
                 withObject:[NSApplication sharedApplication] 
                 withObject:@"app"];
        [[[NSApplication sharedApplication] mainMenu] addItem:fscMenuItem];
    }
#endif
}

@end
