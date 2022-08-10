import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'utility_yaml_platform_interface.dart';

/// An implementation of [UtilityYamlPlatform] that uses method channels.
class MethodChannelUtilityYaml extends UtilityYamlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('utility_yaml');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
