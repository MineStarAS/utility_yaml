import 'package:yaml/yaml.dart';

import 'yamlConfiguration.dart';

class YamlMapConverter {
  YamlMapConverter(YamlMap? yamlMap) {
    if (yamlMap == null) {
      _yaml = YamlConfiguration();
    } else {
      _yaml = YamlConfiguration.fromYamlMap(yamlMap);
    }
  }

  late final YamlConfiguration _yaml;

  Map<String, dynamic> toMap<T>() {
    final Map<String, dynamic> map = {};

    final type = T.toString().split('<').first;

    if (type == 'Map') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getMap(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (type == 'List') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getList(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (type == 'bool') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getBoolean(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (type == 'int') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getInt(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (type == 'double') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getDouble(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (type == 'String') {
      for (final key in _yaml.keys()) {
        final value = _yaml.getString(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    return map;
  }

  Map<String, dynamic> toMapOfSampleValue(dynamic sampleValue) {
    final Map<String, dynamic> map = {};

    if (sampleValue is Map) {
      for (final key in _yaml.keys()) {
        final value = _yaml.getMap(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (sampleValue is List) {
      for (final key in _yaml.keys()) {
        final value = _yaml.getList(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (sampleValue is bool) {
      for (final key in _yaml.keys()) {
        final value = _yaml.getBoolean(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (sampleValue is int) {
      for (final key in _yaml.keys()) {
        final value = _yaml.getInt(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    if (sampleValue is double) {
      for (final key in _yaml.keys()) {
        final value = _yaml.getDouble(key);
        if (value != null) map[key] = value;
      }
      return map;
    }

    for (final key in _yaml.keys()) {
      final value = _yaml.getString(key);
      if (value != null) map[key] = value;
    }

    return map;
  }
}