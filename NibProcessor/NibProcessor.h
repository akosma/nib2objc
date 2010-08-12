//
//  NibProcessor.h
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Adrian Kosmaczewski 2009
//

#import <Cocoa/Cocoa.h>

typedef enum {
    NibProcessorCodeStyleProperties = 1,
    NibProcessorCodeStyleSetter = 2
} NibProcessorCodeStyle;

@interface NibProcessor : NSObject
{
@private
    NSDictionary *_dictionary;
    NSMutableString *_output;
    NSMutableData *_data;
    NSString *_filename;
    NibProcessorCodeStyle _codeStyle;
}

@property (nonatomic, copy) NSString *input;
@property (nonatomic, readonly) NSString *output;
@property (nonatomic) NibProcessorCodeStyle codeStyle;

- (void)process;

- (NSString *)inputAsText;
- (NSDictionary *)inputAsDictionary;

@end
