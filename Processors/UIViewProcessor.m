//
//  UIViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIViewProcessor.h"

@interface UIViewProcessor (Private)

- (void)constructor;
- (void)properties;

@end


@implementation UIViewProcessor

@synthesize instanceName;

- (id)init
{
    if (self = [super init])
    {
        klass = @"UIView";
        instanceName = @"view";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)processDictionary:(NSDictionary *)dictionary into:(NSMutableString *)outputString
{
    dict = dictionary;
    output = outputString;
    [self constructor];
    [self properties];
}

- (NSString *)rectFromPoint:(NSString *)pointString size:(NSString *)sizeString
{
    NSPoint point = NSPointFromString(pointString);
    NSSize size = NSSizeFromString(sizeString);
    return [NSString stringWithFormat:@"CGRectMake(%1.1f, %1.1f, %1.1f, %1.1f)", point.x, point.y, size.width, size.height];
}

- (NSString *)colorFromValue:(NSString *)colorString
{
    NSMutableString *color = [[NSMutableString alloc] init];
    if ([colorString hasPrefix:@"NSCalibratedRGBColorSpace"])
    {
        float red, green, blue, alpha;
        sscanf([colorString UTF8String], "NSCalibratedRGBColorSpace %f %f %f %f", &red, &green, &blue, &alpha);
        [color appendFormat:@"[UIColor colorWithRed:%1.3f green:%1.3f blue:%1.3f alpha:%1.3f]", red, green, blue, alpha];
    }
    else if ([colorString hasPrefix:@"NSCustomColorSpace Generic Gray colorspace "])
    {
        float gray, alpha;
        sscanf([colorString UTF8String], "NSCustomColorSpace Generic Gray colorspace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([colorString hasPrefix:@"NSCalibratedWhiteColorSpace"])
    {
        float gray, alpha;
        sscanf([colorString UTF8String], "NSCalibratedWhiteColorSpace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([colorString hasPrefix:@"NSCustomColorSpace Generic CMYK colorspace "])
    {
        float cyan, magenta, yellow, black, alpha;
        sscanf([colorString UTF8String], "NSCustomColorSpace Generic CMYK colorspace %f %f %f %f %f", &cyan, &magenta, &yellow, &black, &alpha);
        // There is no method in UIColor for CMYK colors...
        [color appendFormat:@"[UIColor colorWithCGColor:CGColorCreate(kCGColorSpaceGenericCMYK, {%1.3f, %1.3f, %1.3f, %1.3f, %1.3f})]", cyan, magenta, yellow, black, alpha];
    }
    else
    {
        [color appendString:colorString];
    }
    NSString *colorReturn = [color copy];
    [color release];
    return colorReturn;
}

- (NSString *)contentModeFromValue:(NSNumber *)contentMode
{
    NSString *value = @"";
    switch ([contentMode intValue])
    {
        case 0:
            value = @"UIViewContentModeScaleToFill";
            break;
            
        case 1:
            value = @"UIViewContentModeScaleAspectFit";
            break;
            
        case 2:
            value = @"UIViewContentModeScaleAspectFill";
            break;
            
        case 3:
            value = @"UIViewContentModeRedraw";
            break;
            
        case 4:
            value = @"UIViewContentModeCenter";
            break;
            
        case 5:
            value = @"UIViewContentModeTop";
            break;
            
        case 6:
            value = @"UIViewContentModeBottom";
            break;
            
        case 7:
            value = @"UIViewContentModeLeft";
            break;
            
        case 8:
            value = @"UIViewContentModeRight";
            break;
        
        case 9:
            value = @"UIViewContentModeTopLeft";
            break;
            
        case 10:
            value = @"UIViewContentModeTopRight";
            break;
            
        case 11:
            value = @"UIViewContentModeBottomLeft";
            break;
            
        case 12:
            value = @"UIViewContentModeBottomRight";
            break;
    }
    return value;
}

- (NSString *)booleanFromValue:(NSNumber *)boolean
{
    return ([boolean boolValue] == 1) ? @"YES" : @"NO";
}

#pragma mark -
#pragma mark Private methods

- (void)constructor
{
    NSString *rect = [self rectFromPoint:[dict objectForKey:@"frameOrigin"] size:[dict objectForKey:@"frameSize"]];
    [output appendFormat:@"%@ *%@ = [[%@ alloc] initWithFrame:%@];\n", klass, instanceName, klass, rect];
}

- (void)properties
{
    for (id item in dict)
    {
        id value = [dict objectForKey:item];
        
        if ([item isEqualToString:@"alpha"])
        {
            [output appendFormat:@"%@.alpha = %1.1f;\n", instanceName, [value floatValue]];
        }
        else if ([item isEqualToString:@"hidden"])
        {
            [output appendFormat:@"%@.hidden = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"opaqueForDevice"])
        {
            [output appendFormat:@"%@.opaque = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"clipsSubviews"])
        {
            [output appendFormat:@"%@.clipsToBounds = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"clearsContextBeforeDrawing"])
        {
            [output appendFormat:@"%@.clearsContextBeforeDrawing = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"userInteractionEnabled"])
        {
            [output appendFormat:@"%@.userInteractionEnabled = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"multipleTouchEnabled"])
        {
            [output appendFormat:@"%@.multipleTouchEnabled = %@;\n", instanceName, [self booleanFromValue:value]];
        }
        else if ([item isEqualToString:@"tag"])
        {
            [output appendFormat:@"%@.tag = %d;\n", instanceName, [value intValue]];
        }
        else if ([item isEqualToString:@"backgroundColor"])
        {
            [output appendFormat:@"%@.backgroundColor = %@;\n", instanceName, [self colorFromValue:value]];
        }
        else if ([item isEqualToString:@"contentMode"])
        {
            [output appendFormat:@"%@.contentMode = %@;\n", instanceName, [self contentModeFromValue:value]];
        }
        else
        {
            [output appendFormat:@"/* property skipped: %@ = %@ */\n", item, value];
        }
    }
}

@end
