//
//  UIPickerViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Adrian Kosmaczewski 2009
//

#import "UIPickerViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIPickerViewProcessor

RegisterOnLoadWithIB

- (void)processKey:(id)item value:(id)value {
    if ([item isEqualToString:@"showsSelectionIndicator"]) {
        [output setObject:[value booleanString] forKey:item];
    }
    else {
        [super processKey:item value:value];
    }
}

@end
