//
//  UIDatePickerProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UIDatePickerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"

@implementation UIDatePickerProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIDatePicker";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"datePickerMode"])
    {
        [output setObject:[value datePickerModeString] forKey:item];
    }
    else if ([item isEqualToString:@"timeZone"])
    {
        // NSTimeZone instances are not supported by ibtool
        [output setObject:@"nil" forKey:item];
    }
    else if ([item isEqualToString:@"locale"])
    {
        // NSLocale instances are not supported by ibtool
        [output setObject:@"nil" forKey:item];
    }
    else if ([item isEqualToString:@"minuteInterval"])
    {
        // NSLocale instances are not supported by ibtool
        [output setObject:[value intString] forKey:item];
    }
    else if ([item isEqualToString:@"date"])
    {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeStyle:NSDateFormatterFullStyle];

        NSString *stringObject = [NSString stringWithFormat:@"dateFromString(%@)", [[formatter stringFromDate:value] quotedAsCodeString]];
        [output setObject:stringObject forKey:item];
        [output setObject:[NSString dateFromStringFunction] forKey:@"__helper__"];
    }
    else if ([item isEqualToString:@"maximumDate"])
    {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeStyle:NSDateFormatterFullStyle];
        
        NSString *stringObject = [NSString stringWithFormat:@"dateFromString(%@)", [[formatter stringFromDate:value] quotedAsCodeString]];
        [output setObject:stringObject forKey:item];
        [output setObject:[NSString dateFromStringFunction] forKey:@"__helper__"];
    }
    else if ([item isEqualToString:@"minimumDate"])
    {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeStyle:NSDateFormatterFullStyle];
        
        NSString *stringObject = [NSString stringWithFormat:@"dateFromString(%@)", [[formatter stringFromDate:value] quotedAsCodeString]];
        [output setObject:stringObject forKey:item];
        [output setObject:[NSString dateFromStringFunction] forKey:@"__helper__"];
    }
    else if ([item isEqualToString:@"countDownDuration"])
    {
        // NSLocale instances are not supported by ibtool
        [output setObject:[value intString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
