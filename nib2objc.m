#import <Foundation/Foundation.h>

NSDictionary *getPropertyList(NSData *data)
{
    NSString *errorStr = nil;
    NSPropertyListFormat format;
    NSDictionary *propertyList = [NSPropertyListSerialization propertyListFromData:data
                                                                  mutabilityOption:NSPropertyListImmutable
                                                                            format:&format
                                                                  errorDescription:&errorStr];
    [errorStr release];
    return propertyList;
}

NSString *getText(NSData *data)
{
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // Verify that we have the required number of parameters in the command line
    if (argc != 2)
    {
        NSLog(@"This utility requires a valid NIB file path as parameter.");
        return 0;
    }
    
    // Test that the file exists, and that it is not a directory
    NSString *nibFile = [NSString stringWithCString:argv[1]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL fileExists = [manager fileExistsAtPath:nibFile isDirectory:&isDirectory];
    if (!fileExists || isDirectory)
    {
        NSLog(@"This utility requires a valid NIB file path as parameter.");
        return 0;
    }

    // Build the NSTask that will run the ibtool utility
    NSArray *arguments = [NSArray arrayWithObjects:nibFile, @"--objects", 
                          @"--hierarchy", @"--connections", @"--classes", nil];
    NSTask *task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *readHandle = [pipe fileHandleForReading];
    NSData *data = nil;
    NSMutableData *output = [[NSMutableData alloc] init];
    
    [task setLaunchPath:@"/usr/bin/ibtool"];
    [task setArguments:arguments];
    [task setStandardOutput:pipe];
    [task launch];

    while ((data = [readHandle availableData]) && [data length]) 
    {
        [output appendData:data];
    }

    // This dictionary is ready to be parsed, and it contains
    // everything we need from the NIB file.
    NSDictionary *dict = getPropertyList(output);
    NSLog(@"items: %d", [[dict objectForKey:@"com.apple.ibtool.document.hierarchy"] count]);

    [output release];
    [task release];
    [pool drain];
    return 0;
}
