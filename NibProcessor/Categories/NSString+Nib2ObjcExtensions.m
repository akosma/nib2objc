//
//  NSString+Nib2ObjcExtensions.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "NSString+Nib2ObjcExtensions.h"

@implementation NSString (Nib2ObjcExtensions)

+ (NSString *)rectStringFromPoint:(NSString *)pointString size:(NSString *)sizeString
{
    NSPoint point = NSPointFromString(pointString);
    NSSize size = NSSizeFromString(sizeString);
    return [NSString stringWithFormat:@"CGRectMake(%1.1f, %1.1f, %1.1f, %1.1f)", point.x, point.y, size.width, size.height];
}

+ (NSString *)dateFromStringFunction
{
    NSMutableString *function = [[[NSMutableString alloc] init] autorelease];
    [function appendString:@"NSDate *dateFromString(NSString *input)\n"];
    [function appendString:@"{\n"];
    [function appendString:@"    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];\n"];
    [function appendString:@"    [formatter setDateStyle:NSDateFormatterFullStyle];\n"];
    [function appendString:@"    [formatter setTimeStyle:NSDateFormatterFullStyle];\n"];
    [function appendString:@"    NSDate *date = [formatter dateFromString:input];\n"];
    [function appendString:@"    return date;\n"];
    [function appendString:@"}\n"];
    return function;
}

- (NSString *)sizeString
{
    NSSize size = NSSizeFromString(self);
    return [NSString stringWithFormat:@"CGSizeMake(%1.1f, %1.1f)", size.width, size.height];
}

- (NSString *)colorString
{
    NSMutableString *color = [[[NSMutableString alloc] init] autorelease];
    if ([self hasPrefix:@"NSCalibratedRGBColorSpace"])
    {
        float red, green, blue, alpha;
        sscanf([self UTF8String], "NSCalibratedRGBColorSpace %f %f %f %f", &red, &green, &blue, &alpha);
        [color appendFormat:@"[UIColor colorWithRed:%1.3f green:%1.3f blue:%1.3f alpha:%1.3f]", red, green, blue, alpha];
    }
    else if ([self hasPrefix:@"NSCustomColorSpace Generic Gray colorspace "])
    {
        float gray, alpha;
        sscanf([self UTF8String], "NSCustomColorSpace Generic Gray colorspace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([self hasPrefix:@"NSCalibratedWhiteColorSpace"])
    {
        float gray, alpha;
        sscanf([self UTF8String], "NSCalibratedWhiteColorSpace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([self hasPrefix:@"NSCustomColorSpace Generic CMYK colorspace "])
    {
        float cyan, magenta, yellow, black, alpha;
        sscanf([self UTF8String], "NSCustomColorSpace Generic CMYK colorspace %f %f %f %f %f", &cyan, &magenta, &yellow, &black, &alpha);
        // There is no method in UIColor for CMYK colors...
        [color appendFormat:@"[UIColor colorWithCGColor:CGColorCreate(kCGColorSpaceGenericCMYK, {%1.3f, %1.3f, %1.3f, %1.3f, %1.3f})]", cyan, magenta, yellow, black, alpha];
    }
    else
    {
        [color appendString:self];
    }
    return color;
}

- (NSString *)quotedAsCodeString
{
    return [NSString stringWithFormat:@"@\"%@\"", self];
}

- (NSString *)capitalize
{
    // Adapted from 
    // http://stackoverflow.com/questions/2432452/how-to-capitalize-the-first-word-of-the-sentece-in-objective-c
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) 
                                         withString:[[self substringToIndex:1] uppercaseString]];
}

@end
