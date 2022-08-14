import 'package:yaml/yaml.dart';

abstract class Yamlble {
  YamlMap toYamlMap();

  String asString() {
    return toYamlMap().toString();
  }

  YamlMap? loadYamlMap(String asString) {
    try {
      return loadYaml(asString);
    } catch (e) {
      print(e);
      return null;
    }
  }
}