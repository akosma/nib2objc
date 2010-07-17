//
//  MKMapViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Adrian Kosmaczewski 2010
//

#import "MKMapViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation MKMapViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"MKMapView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"showsUserLocation"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    if ([item isEqualToString:@"mapType"])
    {
        [output setObject:[value mapTypeString] forKey:item];
    }
    else if ([item isEqualToString:@"scrollEnabled"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else if ([item isEqualToString:@"zoomEnabled"])
    {
        [output setObject:[value booleanString] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
