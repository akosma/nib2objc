//
//  NSCustomViewProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSCustomViewProcessor.h"

@implementation NSCustomViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)constructorString
{
	return [NSString stringWithFormat:@"[[[%@ alloc] initWithFrame:%@] autorelease]", [self.input objectForKey:@"className"], [self frameString]];
}

@end
