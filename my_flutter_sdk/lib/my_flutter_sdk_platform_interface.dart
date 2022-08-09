import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_flutter_sdk_method_channel.dart';

abstract class MyFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a MyFlutterSdkPlatform.
  MyFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyFlutterSdkPlatform _instance = MethodChannelMyFlutterSdk();

  /// The default instance of [MyFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyFlutterSdk].
  static MyFlutterSdkPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(MyFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
