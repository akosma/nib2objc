//
//  UISwitchProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UISwitchProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISwitchProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISwitch";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"on"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }    
}

@end
