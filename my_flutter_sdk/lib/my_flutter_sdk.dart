
import 'my_flutter_sdk_platform_interface.dart';

class MyFlutterSdk {
  Future<String?> getPlatformVersion() {
    return MyFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
