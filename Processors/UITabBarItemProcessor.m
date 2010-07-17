//
//  UITabBarItemProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UITabBarItemProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UITabBarItemProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITabBarItem";
}

- (NSString *)constructorString
{
    NSString *constructor = @"";
    NSNumber *systemItemIdentifier = [self.input objectForKey:@"systemItemIdentifier"];
    if ([systemItemIdentifier intValue] == -1)
    {
        NSString *title = [[self.input objectForKey:@"title"] quotedAsCodeString];
        NSString *tag = [[self.input objectForKey:@"tag"] intString];
        constructor = [NSString stringWithFormat:@"[[%@ alloc] initWithTitle:%@ image:nil tag:%@]", [self getProcessedClassName], title, tag];
    }
    else
    {
        NSString *systemItem = [systemItemIdentifier tabBarSystemItemString];
        NSString *tag = [[self.input objectForKey:@"tag"] intString];
        constructor = [NSString stringWithFormat:@"[[%@ alloc] initWithTabBarSystemItem:%@ tag:%@]", [self getProcessedClassName], systemItem, tag];
    }
    return constructor;
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"badgeValue"])
    {
        [output setObject:[value quotedAsCodeString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
