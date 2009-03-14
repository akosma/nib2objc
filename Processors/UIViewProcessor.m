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
            
        default:
            break;
    }
    return value;
}

- (NSString *)booleanFromValue:(NSNumber *)boolean
{
    return ([boolean boolValue] == 1) ? @"YES" : @"NO";
}

- (NSString *)autoresizingMaskFromValue:(NSNumber *)autoresizingMask
{
    // From the documentation
    enum 
    {
        UIViewAutoresizingNone                 = 0,
        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
        UIViewAutoresizingFlexibleWidth        = 1 << 1,
        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
        UIViewAutoresizingFlexibleHeight       = 1 << 4,
        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
    };
    
    NSUInteger mask = [autoresizingMask intValue];
    NSMutableString *maskValue = [[NSMutableString alloc] init];
    
    if (mask == UIViewAutoresizingNone) 
    {
        [maskValue appendString:@"UIViewAutoresizingNone"];
    }
    if ((mask & UIViewAutoresizingFlexibleLeftMargin) == UIViewAutoresizingFlexibleLeftMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleLeftMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleWidth) == UIViewAutoresizingFlexibleWidth)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleWidth"];
    }
    if ((mask & UIViewAutoresizingFlexibleRightMargin) == UIViewAutoresizingFlexibleRightMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleRightMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleTopMargin) == UIViewAutoresizingFlexibleTopMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleTopMargin"];
    }
    if ((mask & UIViewAutoresizingFlexibleHeight) == UIViewAutoresizingFlexibleHeight)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleHeight"];
    }
    if ((mask & UIViewAutoresizingFlexibleBottomMargin) == UIViewAutoresizingFlexibleBottomMargin)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"UIViewAutoresizingFlexibleBottomMargin"];
    }
    
    NSString *value = [maskValue copy];
    [maskValue release];
    return value;
}

- (NSString *)textAlignmentFromValue:(NSNumber *)textAlignment
{
    NSString *value = @"";
    switch ([textAlignment intValue])
    {
        case 0:
            value = @"UITextAlignmentLeft";
            break;

        case 1:
            value = @"UITextAlignmentCenter";
            break;

        case 2:
            value = @"UITextAlignmentRight";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)fontFromValue:(NSDictionary *)font
{
    NSString *name = [font objectForKey:@"Name"];
    float size = [[font objectForKey:@"Size"] floatValue];
    return [NSString stringWithFormat:@"[UIFont fontWithName:@\"%@\" size:%1.3f]", name, size];
}

- (NSString *)borderStyleFromValue:(NSNumber *)borderStyle
{
    NSString *value = @"";
    switch ([borderStyle intValue])
    {
        case 0:
            value = @"UITextBorderStyleNone";
            break;
            
        case 1:
            value = @"UITextBorderStyleLine";
            break;
            
        case 2:
            value = @"UITextBorderStyleBezel";
            break;
            
        case 3:
            value = @"UITextBorderStyleRoundedRect";
            break;
            
        default:
            break;
    }
    return value;
}

- (NSString *)contentHorizontalAlignmentForValue:(NSNumber *)contentHorizontalAlignment
{
    NSString *value = @"";
    switch ([contentHorizontalAlignment intValue])
    {
        case 0:
            value = @"UIControlContentHorizontalAlignmentCenter";
            break;
            
        case 1:
            value = @"UIControlContentHorizontalAlignmentLeft";
            break;
            
        case 2:
            value = @"UIControlContentHorizontalAlignmentRight";
            break;
            
        case 3:
            value = @"UIControlContentHorizontalAlignmentFill";
            break;

        default:
            break;
    }
    return value;
}

- (NSString *)contentVerticalAlignmentForValue:(NSNumber *)contentVerticalAlignment
{
    NSString *value = @"";
    switch ([contentVerticalAlignment intValue])
    {
        case 0:
            value = @"UIControlContentVerticalAlignmentCenter";
            break;
            
        case 1:
            value = @"UIControlContentVerticalAlignmentTop";
            break;
            
        case 2:
            value = @"UIControlContentVerticalAlignmentBottom";
            break;
            
        case 3:
            value = @"UIControlContentVerticalAlignmentFill";
            break;
            
        default:
            break;
    }
    return value;
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
        [self processUnknownProperty:item value:value];
    }
}

- (void)processUnknownProperty:(id)item value:(id)value
{
    // Subclasses can override this method for their own properties.
    // In those cases, call [super processUnknownProperty:item value:value];
    // to be sure that mother classes do their work.
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
    else if ([item isEqualToString:@"autoresizingMask"])
    {
        [output appendFormat:@"%@.autoresizingMask = %@;\n", instanceName, [self autoresizingMaskFromValue:value]];
    }
    else
    {
        // Uncomment this to see what's being skipped
        // [output appendFormat:@"/* property skipped: %@ = %@ */\n", item, value];
    }
}

@end
