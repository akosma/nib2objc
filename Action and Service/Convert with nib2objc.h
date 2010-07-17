//
//  Convert with nib2objc.h
//  Convert with nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright (c) 2010 __MyCompanyName__, All Rights Reserved.
//

#import <Cocoa/Cocoa.h>
#import <Automator/AMBundleAction.h>

@interface Convert_with_nib2objc : AMBundleAction 
{
}

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
