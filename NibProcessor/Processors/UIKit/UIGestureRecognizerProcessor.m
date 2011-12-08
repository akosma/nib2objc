//
//  UIGestureRecognizerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIGestureRecognizerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIGestureRecognizerProcessor

RegisterOnLoadWithIB

BooleanKey(cancelsTouchesInView)
BooleanKey(delaysTouchesBegan)
BooleanKey(delaysTouchesEnded)

@end
