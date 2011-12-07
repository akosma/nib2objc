//
//  UIBarButtonItemProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UIBarButtonItemProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"

@implementation UIBarButtonItemProcessor

RegisterOnLoadWithIB

- (NSString *)constructorString {
    NSString *constructor;
    NSNumber *systemItemIdentifier = [self.input objectForKey:@"systemItemIdentifier"];
    if ([systemItemIdentifier intValue] == -1) {
        NSString *title = [[self.input objectForKey:@"title"] quotedAsCodeString];
        NSString *style = [[self.input objectForKey:@"style"] uiBarButtonItemStyleString];
        constructor = [NSString stringWithFormat:@"[[%@ alloc] initWithTitle:%@ style:%@ target:nil action:nil]", [self getProcessedClassName], title, style];
    }
    else {
        NSString *systemItem = [systemItemIdentifier uiBarButtonSystemItemString];
        constructor = [NSString stringWithFormat:@"[[%@ alloc] initWithBarButtonSystemItem:%@ target:nil action:nil]", [self getProcessedClassName], systemItem];
    }
    return constructor;
}

- (void)processKey:(id)item value:(id)value {
    if ([item isEqualToString:@"style"]) {
        [output setObject:[value uiBarButtonItemStyleString] forKey:item];
    }
    else if ([item isEqualToString:@"width"]) {
        [output setObject:[value floatString] forKey:item];
    }
    else {
        [super processKey:item value:value];
    }
}

@end
