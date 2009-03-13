//
//  UIViewProcessor.h
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UIViewProcessor : NSObject 
{
@protected
    NSString *klass;
    NSDictionary *dict;
    NSMutableString *output;
}

- (void)processDictionary:(NSDictionary *)dictionary into:(NSMutableString *)outputString;

@end
