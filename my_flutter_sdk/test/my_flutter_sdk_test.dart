import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_sdk/my_flutter_sdk.dart';
import 'package:my_flutter_sdk/my_flutter_sdk_platform_interface.dart';
import 'package:my_flutter_sdk/my_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyFlutterSdkPlatform 
    with MockPlatformInterfaceMixin
    implements MyFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyFlutterSdkPlatform initialPlatform = MyFlutterSdkPlatform.instance;

  test('$MethodChannelMyFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    MyFlutterSdk myFlutterSdkPlugin = MyFlutterSdk();
    MockMyFlutterSdkPlatform fakePlatform = MockMyFlutterSdkPlatform();
    MyFlutterSdkPlatform.instance = fakePlatform;
  
    expect(await myFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
