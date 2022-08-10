import 'package:flutter_test/flutter_test.dart';
import 'package:utility_yaml/utility_yaml.dart';
import 'package:utility_yaml/utility_yaml_platform_interface.dart';
import 'package:utility_yaml/utility_yaml_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUtilityYamlPlatform 
    with MockPlatformInterfaceMixin
    implements UtilityYamlPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UtilityYamlPlatform initialPlatform = UtilityYamlPlatform.instance;

  test('$MethodChannelUtilityYaml is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUtilityYaml>());
  });

  test('getPlatformVersion', () async {
    UtilityYaml utilityYamlPlugin = UtilityYaml();
    MockUtilityYamlPlatform fakePlatform = MockUtilityYamlPlatform();
    UtilityYamlPlatform.instance = fakePlatform;
  
    expect(await utilityYamlPlugin.getPlatformVersion(), '42');
  });
}
