//
//  NibProcessor.h
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

@interface NibProcessor : NSObject
{
@private
    NSDictionary *dictionary;
    NSMutableString *output;
    NSMutableData *data;
    NSString *filename;
}

@property (nonatomic, retain) NSString *input;
@property (nonatomic, readonly) NSString *output;

- (NSString *)inputAsText;
- (NSDictionary *)inputAsDictionary;

@end

