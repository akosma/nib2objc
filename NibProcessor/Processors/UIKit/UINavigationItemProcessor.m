//
//  UINavigationItemProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UINavigationItemProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"

@implementation UINavigationItemProcessor

RegisterOnLoadWithIB

QuotedKey(title)
QuotedKey(prompt)

- (NSString *)constructorString {
    NSString *title = [[self.input objectForKey:@"title"] quotedAsCodeString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithTitle:%@]", [self getProcessedClassName], title];
}

@end
