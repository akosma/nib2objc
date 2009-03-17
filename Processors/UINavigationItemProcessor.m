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

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UINavigationItem";
}

- (NSString *)constructorString
{
    NSString *title = [[self.input objectForKey:@"title"] quotedAsCodeString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithTitle:%@]", [self getProcessedClassName], title];
}

- (void)processKey:(id)item value:(id)value
{
    id object = nil;
    if ([item isEqualToString:@"class"])
    {
        object = [self getProcessedClassName];
    }
    else if ([item isEqualToString:@"title"])
    {
        object = [value quotedAsCodeString];
    }
    else if ([item isEqualToString:@"prompt"])
    {
        object = [value quotedAsCodeString];
    }
    if (object != nil)
    {
        [output setObject:object forKey:item];
    }
}

@end
