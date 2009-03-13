//
//  Processor.h
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NSDictionary *getPropertyList(NSData *data);

NSDictionary *getDictionaryFromNIB(NSString *nibFile);

NSString *getText(NSData *data);

NSString *processDictionary(NSDictionary *dict);
