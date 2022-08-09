#import "MyFlutterSdkPlugin.h"
#if __has_include(<my_flutter_sdk/my_flutter_sdk-Swift.h>)
#import <my_flutter_sdk/my_flutter_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_flutter_sdk-Swift.h"
#endif

@implementation MyFlutterSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyFlutterSdkPlugin registerWithRegistrar:registrar];
}
@end
