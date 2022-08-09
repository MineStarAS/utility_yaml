import 'dart:io';

import 'package:yaml/yaml.dart';

class YamlConfiguration {
  YamlConfiguration(this._yamlMap);

  YamlConfiguration.empty() {
    _yamlMap = {};
  }

  YamlConfiguration.loadFile(File file) {
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      final Map<String, dynamic> map = {};

      yamlMap.forEach((key, value) {
        map[key] = value;
      });

      _yamlMap = map;
    } catch (e) {
      print(e);
      _yamlMap = {};
    }
  }

  YamlConfiguration.loadFilePath(String path) {
    final file = File(path);
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      final Map<String, dynamic> map = {};

      yamlMap.forEach((key, value) {
        map[key] = value;
      });

      _yamlMap = map;
    } catch (e) {
      print(e);
      _yamlMap = {};
    }
  }

  late final Map<String, dynamic> _yamlMap;

  ///Check Functions
  bool keyContains(String key) {
    final value = _yamlMap[key];
    return value != null;
  }

  bool isBoolean(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as bool;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isString(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as String;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isInt(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as int;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isDouble(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as double;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isList(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as List;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isMap(String key) {
    try {
      if (!keyContains(key)) return false;
      _yamlMap[key] as Map<dynamic, dynamic>;
      return true;
    } catch (_) {
      return false;
    }
  }

  ///Get Functions
  String? getString(String key) {
    if (!isString(key)) return null;
    return _yamlMap[key];
  }

  bool? getBoolean(String key) {
    if (!isBoolean(key)) return null;
    return _yamlMap[key];
  }

  int? getInt(String key) {
    if (!isInt(key)) return null;
    return _yamlMap[key];
  }

  double? getDouble(String key) {
    if (!isDouble(key)) return null;
    return _yamlMap[key];
  }

  List? getList(String key) {
    if (!isList(key)) return null;
    return _yamlMap[key];
  }

  YamlMap? getMap(String key) {
    if (!isMap(key)) return null;
    return _yamlMap[key];
  }

  ///Put Functions
  void put(String key, Object value) {
    _yamlMap[key] = value;
  }

  ///Save Function
  void save(File file) {
    file.writeAsStringSync(_convertYamlFile());
  }

  String _convertYamlFile() {
    return _convertMap(_yamlMap, 0);
  }

  String _convertMap(Map<dynamic, dynamic> map, final int order) {
    String string = '';
    var tab = '';
    for (int i = 0; i < order; i++) {
      tab += '  ';
    }

    map.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        string += '$key:\n';
        string += '${_convertMap(value, order + 1)}\n';
      } else if (value is List<dynamic>) {
        string += '$key:\n';
        string += '${_convertList(value, order + 1)}\n';
      } else {
        string += '$tab$key: $value\n';
      }
    });

    return string;
  }

  String _convertList(List<dynamic> list, final int order) {
    String string = '';
    var tab = '';
    for (int i = 0; i < order; i++) {
      tab += '  ';
    }

    for (var value in list) {
      string += '$tab- $value\n';
    }

    return string;
  }
}
