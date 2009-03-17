//
//  UIActivityIndicatorViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UIActivityIndicatorViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIActivityIndicatorViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIActivityIndicatorView";
}

- (NSString *)constructorString
{
    NSString *style = [[self.input objectForKey:@"style"] activityIndicatorViewStyleString];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithActivityIndicatorStyle:%@]", [self getProcessedClassName], style];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"hidesWhenStopped"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"animating"])
    {
        BOOL isAnimating = [value boolValue];

        NSString *stringOutput = (isAnimating) ? @"startAnimating" : @"stopAnimating";
        [output setObject:stringOutput forKey:[NSString stringWithFormat:@"__method__%@", item]];
    }
    else
    {
        [super processKey:item value:value];
    }
}    

@end
