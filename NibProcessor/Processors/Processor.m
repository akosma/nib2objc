//
//  Processor.m
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import "Processor.h"

#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

#import "UIViewProcessor.h"
#import "UITextFieldProcessor.h"
#import "UIProgressViewProcessor.h"
#import "UISwitchProcessor.h"
#import "UISliderProcessor.h"
#import "UILabelProcessor.h"
#import "UIActivityIndicatorViewProcessor.h"
#import "UIPageControlProcessor.h"
#import "UIButtonProcessor.h"
#import "UISegmentedControlProcessor.h"
#import "UIScrollViewProcessor.h"
#import "UITableViewProcessor.h"
#import "UIImageViewProcessor.h"
#import "UITextViewProcessor.h"
#import "UIPickerViewProcessor.h"
#import "UIWebViewProcessor.h"
#import "UITableViewCellProcessor.h"
#import "UIDatePickerProcessor.h"
#import "UINavigationBarProcessor.h"
#import "UINavigationItemProcessor.h"
#import "UIBarButtonItemProcessor.h"
#import "UISearchBarProcessor.h"
#import "UIToolbarProcessor.h"
#import "UITabBarProcessor.h"
#import "UITabBarItemProcessor.h"
#import "MKMapViewProcessor.h"
#import "UIPinchGestureRecognizerProcessor.h"
#import "UIRotationGestureRecognizerProcessor.h"
#import "UISwipeGestureRecognizerProcessor.h"
#import "UIPanGestureRecognizerProcessor.h"
#import "UILongPressGestureRecognizerProcessor.h"
#import "UIViewControllerProcessor.h"
#import "UITableViewControllerProcessor.h"
#import "UIStepperProcessor.h"
#import "GLKViewControllerProcessor.h"
#import "UITapGestureRecognizerProcessor.h"
#import "GLKViewProcessor.h"
#import "ProxyObjectProcessor.h"

@interface Processor (Protected)

- (NSString *)getProcessedClassName;
- (NSString *)constructorString;

@end

@implementation Processor

@synthesize input;

+ (Processor *)processorForClass:(NSString *)klass
{
    Processor *processor = nil;

    if ([klass isEqualToString:@"IBUIView"]) processor = [[UIViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITextField"]) processor = [[UITextFieldProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIProgressView"]) processor = [[UIProgressViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUISwitch"]) processor = [[UISwitchProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUISlider"]) processor = [[UISliderProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUILabel"]) processor = [[UILabelProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIActivityIndicatorView"]) processor = [[UIActivityIndicatorViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIPageControl"]) processor = [[UIPageControlProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIButton"]) processor = [[UIButtonProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUISegmentedControl"]) processor = [[UISegmentedControlProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIScrollView"]) processor = [[UIScrollViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITableView"]) processor = [[UITableViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIImageView"]) processor = [[UIImageViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITextView"]) processor = [[UITextViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIPickerView"]) processor = [[UIPickerViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIWebView"]) processor = [[UIWebViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITableViewCell"]) processor = [[UITableViewCellProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIDatePicker"]) processor = [[UIDatePickerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUINavigationBar"]) processor = [[UINavigationBarProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUINavigationItem"]) processor = [[UINavigationItemProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIBarButtonItem"]) processor = [[UIBarButtonItemProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUISearchBar"]) processor = [[UISearchBarProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIToolbar"]) processor = [[UIToolbarProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITabBar"]) processor = [[UITabBarProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITabBarItem"]) processor = [[UITabBarItemProcessor alloc] init];
    else if ([klass isEqualToString:@"IBMKMapView"]) processor = [[MKMapViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIPinchGestureRecognizer"]) processor = [[UIPinchGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIRotationGestureRecognizer"]) processor = [[UIRotationGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUISwipeGestureRecognizer"]) processor = [[UISwipeGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIPanGestureRecognizer"]) processor = [[UIPanGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUILongPressGestureRecognizer"]) processor = [[UILongPressGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIViewController"]) processor = [[UIViewControllerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITableViewController"]) processor = [[UITableViewControllerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUIStepper"]) processor = [[UIStepperProcessor alloc] init];
    else if ([klass isEqualToString:@"IBGLKViewController"]) processor = [[GLKViewControllerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBUITapGestureRecognizer"]) processor = [[UITapGestureRecognizerProcessor alloc] init];
    else if ([klass isEqualToString:@"IBGLKView"]) processor = [[GLKViewProcessor alloc] init];
    else if ([klass isEqualToString:@"IBProxyObject"]) processor = [[ProxyObjectProcessor alloc] init];

    return [processor autorelease];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        ignoredProperties = [[NSSet alloc] initWithObjects:@"ibExternalIdentityShowNotesWithSelection", 
                             @"systemItemIdentifier", 
                             @"autoresizesSubviewsForDevice",
                             @"backgroundFilters",
                             @"canDrawConcurrently",
                             @"clipsSubviews",
                             @"contentFilters",
                             @"focusRingType",
                             @"frameCenterRotation",
                             @"alphaValue",
                             @"frameOrigin",
                             @"frameSize",
                             @"ibExternalTranslatesAutoresizingMaskIntoConstraints",
                             @"ibShadowedHorizontalContentCompressionResistancePriority",
                             @"ibShadowedHorizontalContentHuggingPriority",
                             @"ibShadowedVerticalContentCompressionResistancePriority",
                             @"ibShadowedVerticalContentHuggingPriority",
                             @"opaqueForDevice",
                             @"simulatedOrientationMetrics",
                             @"wantsLayer",
                             @"autoresizesArchivedViewToFullSize",
                             @"designatedEntryPoint",
                             @"simulatedStatusBarMetrics",
                             @"contentInset",
                             @"dataMode",
                             @"scrollIndicatorInsets",
                             @"showsSelectionImmediatelyOnTouchBegin",
                             @"ibExternalExplicitLabel",
                             @"fontDescription",
                             @"edgeInsetsContent",
                             @"edgeInsetsImage",
                             @"edgeInsetsTitle",
                             @"highlightedColor",
                             @"proxiedObjectIdentifier",
                             @"ibExternalCustomClassName", nil];
    }
    return self;
}

- (void)dealloc
{
    [ignoredProperties release];
    [output release];
    [input release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public method

- (NSDictionary *)processObject:(NSDictionary *)object
{
    input = [object retain];
    [output release];
    output = [[NSMutableDictionary alloc] init];
    
    for (id item in input)
    {
        id value = [input objectForKey:item];
        [self processKey:item value:value];

#ifdef CONFIGURATION_Debug
        // This will show properties not yet known by nib2objc
        if ([output objectForKey:item] == nil &&
            ![ignoredProperties containsObject:item])
        {
            id object = [NSString stringWithFormat:@"// unknown property: %@", value];
            [output setObject:object forKey:item];
        }
#endif
    }

    // Because of proxy objects, this call should be done at the end
    // when all the properties of the object have been parsed
    [output setObject:[self constructorString] forKey:@"constructor"];
    
    NSString *frameString = [self frameString];
    if (nil != frameString)
    {
        [output setObject:frameString forKey:@"frame"];
    }

    return output;
}

- (void)processKey:(id)item value:(id)value
{
    // Overridden in subclasses
}

- (NSString *)frameString
{
    return nil;
}

- (NSString *)constructorString
{
    // Some subclasses have different constructors than the classic
    // "initWithFrame:", and as such they should override this method.
    return [NSString stringWithFormat:@"[[%@ alloc] init]", [self getProcessedClassName]];
}

@end
