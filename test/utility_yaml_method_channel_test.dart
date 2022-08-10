import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_yaml/utility_yaml_method_channel.dart';

void main() {
  MethodChannelUtilityYaml platform = MethodChannelUtilityYaml();
  const MethodChannel channel = MethodChannel('utility_yaml');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
