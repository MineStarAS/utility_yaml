import 'package:utility_yaml/yamlMapConverter.dart';
import 'package:utility_yaml/yamlble.dart';
import 'package:yaml/src/yaml_node.dart';

main() {
  final test = TestClass(false, 1, 2.3, 'ttt', {'a': 111, 'b': 222, 'c': 333});

  final yamlMap = test.toYamlMap();

  final map = YamlMapConverter(yamlMap).toMap<Map>();

  print(map);
}

class TestClass extends Yamlble {
  TestClass(this.b, this.i, this.d, this.string, this.intMap);

  late final bool b;
  late final int i;
  late final double d;
  late final String string;
  late final Map<String, int> intMap;

  Yamlble fromString(String asString) {
    final yamlMap = loadYamlMap(asString);
    if (yamlMap == null) {
      throw Exception('\'asString\' is not Map\'s string.');
    }
    final b = yamlMap['b'] as bool;
    final i = yamlMap['i'] as int;
    final d = yamlMap['d'] as double;
    final string = yamlMap['string'] as String;
    final intMap = yamlMap['intMap'] as Map<String, int>;
    return TestClass(b, i, d, string, intMap);
  }

  @override
  Yamlble fromYamlMap(YamlMap yamlMap) {
    final b = yamlMap['b'] as bool;
    final i = yamlMap['i'] as int;
    final d = yamlMap['d'] as double;
    final string = yamlMap['string'] as String;
    final intMap = yamlMap['intMap'] as Map<String, int>;
    return TestClass(b, i, d, string, intMap);
  }

  @override
  YamlMap toYamlMap() {
    final map = <String, dynamic>{};
    map['b'] = b;
    map['i'] = i;
    map['d'] = d;
    map['string'] = string;
    map['intMap'] = intMap;
    final yamlMap = loadYamlMap(map.toString());
    if (yamlMap != null) return yamlMap;
    return YamlMap();
  }
}
