import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'utility_yaml_method_channel.dart';

abstract class UtilityYamlPlatform extends PlatformInterface {
  /// Constructs a UtilityYamlPlatform.
  UtilityYamlPlatform() : super(token: _token);

  static final Object _token = Object();

  static UtilityYamlPlatform _instance = MethodChannelUtilityYaml();

  /// The default instance of [UtilityYamlPlatform] to use.
  ///
  /// Defaults to [MethodChannelUtilityYaml].
  static UtilityYamlPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UtilityYamlPlatform] when
  /// they register themselves.
  static set instance(UtilityYamlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
