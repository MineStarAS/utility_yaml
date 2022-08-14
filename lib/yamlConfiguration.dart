import 'dart:io';

import 'package:yaml/yaml.dart';

class YamlConfiguration {
  ///Constructor Function
  YamlConfiguration() {
    _yamlMap = {};
  }

  YamlConfiguration.fromYamlMap(YamlMap? yamlMap) {
    try {
      final Map<String, dynamic> map = {};

      if (yamlMap == null) {
        _yamlMap = {};
        return;
      }

      yamlMap.forEach((key, value) {
        if (value is YamlMap) {
          map[key] = _convertDynamicMap(value.value);
        } else if (value is YamlList) {
          map[key] = _convertDynamicList(value);
        } else {
          map[key] = value;
        }
      });

      _yamlMap = map;
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.loadFile(File file) {
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      final Map<String, dynamic> map = {};

      yamlMap.forEach((key, value) {
        if (value is YamlMap) {
          map[key] = _convertDynamicMap(value.value);
        } else if (value is YamlList) {
          map[key] = _convertDynamicList(value);
        } else {
          map[key] = value;
        }
      });

      _yamlMap = map;
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.loadPath(String path) {
    final file = File(path);
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      final Map<String, dynamic> map = {};

      yamlMap.forEach((key, value) {
        if (value is YamlMap) {
          map[key] = _convertDynamicMap(value.value);
        } else if (value is YamlList) {
          map[key] = _convertDynamicList(value);
        } else {
          map[key] = value;
        }
      });

      _yamlMap = map;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _convertDynamicMap(Map<dynamic, dynamic> map) {
    final newMap = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is YamlMap) {
        newMap[key] = _convertDynamicMap(value.value);
      }else if (value is YamlList) {
        newMap[key] = _convertDynamicList(value);
      } else {
        newMap[key] = value;
      }
    });
    return newMap;
  }

  List<dynamic> _convertDynamicList(YamlList list) {
    final newList = <dynamic>[];
    for (final value in list) {
      if (value is YamlMap) {
        newList.add(_convertDynamicMap(value));
      } else if (value is YamlList) {
        newList.add(_convertDynamicList(value));
      } else {
        newList.add(value);
      }
    }
    return newList;
  }

  ///Field
  late final Map<String, dynamic> _yamlMap;

  ///Get Field
  Set<String> keys() {
    return _yamlMap.keys.toSet();
  }

  Map<String, String> keysType() {
    final Map<String, String> map = {};
    for (var key in _yamlMap.keys) {
      if (!keyContains(key)) {
        map[key] = 'null';
        continue;
      }
      if (isMap(key)) {
        map[key] = 'Map';
        continue;
      }
      if (isList(key)) {
        map[key] = 'List';
        continue;
      }
      if (isBoolean(key)) {
        map[key] = 'Boolean';
        continue;
      }
      if (isInt(key)) {
        map[key] = 'Int';
        continue;
      }
      if (isDouble(key)) {
        map[key] = 'Double';
        continue;
      }
      if (isString(key)) {
        map[key] = 'String';
        continue;
      }
      map[key] = 'Unknown';
      continue;
    }
    return map;
  }

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
      _yamlMap[key] as Map<String, dynamic>;
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

  Map<String, dynamic>? getMap(String key) {
    if (!isMap(key)) return null;
    return _yamlMap[key];
  }

  Map<String, T>? getTypeMap<T>(String key) {
    if (!isMap(key)) return null;

    final newMap = <String, T>{};
    _yamlMap[key].forEach((key, value) {
      if (value is T) {
        newMap[key.toString()] = value;
      }
    });
    return newMap;
  }

  ///Put Functions
  void put(String key, dynamic value) {
    _yamlMap[key] = value;
  }

  ///Save Function
  void saveToFile(File file) {
    file.writeAsStringSync(_convertYamlFile());
  }

  void saveToPath(String path) {
    final file = File(path);
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
        string += '$tab$key:\n';
        string += '${_convertMap(value, order + 1)}\n';
      } else if (value is List<dynamic>) {
        string += '$tab$key:\n';
        string += '${_convertList(value, order + 1)}\n';
      } else {
        string += '$tab$key: $value\n';
      }
      if (map.keys.last == key) {
        final finish = '###F###';
        string += finish;
        string = string.replaceAll('\n$finish', '');
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
      if (value is Map<dynamic, dynamic>) {
        string += '$tab- $value:\n';
        string += '${_convertMap(value, order + 1)}\n';
      } else if (value is List<dynamic>) {
        string += '$tab- $value:\n';
        string += '${_convertList(value, order + 1)}\n';
      } else {
        string += '$tab- $value\n';
      }

      if (list.last == value) {
        final finish = '###F###';
        string += finish;
        string = string.replaceAll('\n$finish', '');
      }
    }

    return string;
  }
}
