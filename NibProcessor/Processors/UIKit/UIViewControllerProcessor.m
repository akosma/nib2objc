//
//  UIViewControllerProcessor.m
//  nib2objc
//
//  Created by Adrian Kosmaczewski on 11/7/11.
//  Copyright (c) 2011 akosma software. All rights reserved.
//

#import "UIViewControllerProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIViewControllerProcessor

RegisterOnLoadWithIB

BooleanKey(definesPresentationContext)
BooleanKey(hidesBottomBarWhenPushed)
BooleanKey(wantsFullScreenLayout)
BooleanKey(providesPresentationContextTransitionStyle)
KeyValueMethod(modalPresentationStyle, uiModalPresentationStyleString)
KeyValueMethod(modalTransitionStyle, uiModalTransitionStyleString)

@end
