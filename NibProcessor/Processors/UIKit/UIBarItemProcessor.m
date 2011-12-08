//
//  UIBarItemProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/17/09.
//  Adrian Kosmaczewski 2009
//

#import "UIBarItemProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIBarItemProcessor

RegisterOnLoadWithIB

QuotedKey(title)
IntKey(tag)
BooleanKey(enabled)
KeyExpressionMethod(image, @"nil")
KeyExpressionMethod(imageInsets, @"UIEdgeInsetsZero")

@end
