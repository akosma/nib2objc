//
//  UISliderProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UISliderProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISliderProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISlider";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"continuous"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"maxValue"])
    {
        [output setObject:[value floatString] forKey:@"maximumValue"];
    }
    else if ([item isEqualToString:@"minValue"])
    {
        [output setObject:[value floatString] forKey:@"minimumValue"];
    }
    else if ([item isEqualToString:@"value"])
    {
        [output setObject:[value floatString] forKey:@"value"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
