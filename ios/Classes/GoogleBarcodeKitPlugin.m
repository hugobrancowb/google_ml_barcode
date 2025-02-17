#import "GoogleBarcodeKitPlugin.h"

@implementation GoogleBarcodeKitPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"google_barcode_kit"
                                     binaryMessenger:[registrar messenger]];
    GoogleBarcodeKitPlugin* instance = [[GoogleBarcodeKitPlugin alloc] init];
    
    // Add vision detectors
    NSMutableArray *handlers = [NSMutableArray new];
    [handlers addObject:[[BarcodeScanner alloc] init]];
    
    instance.handlers = [NSMutableDictionary new];
    for (id<Handler> detector in handlers) {
        for (NSString *key in detector.getMethodsKeys) {
            instance.handlers[key] = detector;
        }
    }
    
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    id<Handler> handler = self.handlers[call.method];
    if (handler != NULL) {
        [handler handleMethodCall:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
