import 'dart:io';

import 'package:yaml/yaml.dart';

import 'yamlble.dart';

/// This class is makes it easy to load and edit yaml files.
class YamlConfiguration {
  ///Constructor Function
  YamlConfiguration() {
    _yamlMap = {};
  }

  /// !!!!! WARNING !!!!!
  /// If the return value of toString() is not simple
  /// because the key is converted to toString(),
  /// problems may occur when saving to a file.
  YamlConfiguration.fromYamlble(Yamlble yamlble) {
    try {
      _yamlMap = _convertMap(yamlble.toYaml());
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.fromMap(Map<dynamic, dynamic> map) {
    try {
      _yamlMap = _convertMap(map);
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.fromYamlMap(YamlMap? yamlMap) {
    try {
      if (yamlMap == null) {
        _yamlMap = {};
        return;
      }

      _yamlMap = _convertMap(yamlMap);
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.loadFile(File file) {
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      _yamlMap = _convertMap(yamlMap);
    } catch (e) {
      rethrow;
    }
  }

  YamlConfiguration.loadPath(String path) {
    final file = File(path);
    try {
      final yamlData = file.readAsStringSync();
      final YamlMap yamlMap = loadYaml(yamlData);

      _yamlMap = _convertMap(yamlMap);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _convertMap(Map<dynamic, dynamic> map) {
    final newMap = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is YamlMap) {
        newMap[key.toString()] = _convertMap(value.value);
      } else if (value is YamlList) {
        newMap[key.toString()] = _convertList(value);
      } else {
        newMap[key.toString()] = value;
      }
    });
    return newMap;
  }

  List<dynamic> _convertList(YamlList list) {
    final newList = <dynamic>[];
    for (final value in list) {
      if (value is YamlMap) {
        newList.add(_convertMap(value));
      } else if (value is YamlList) {
        newList.add(_convertList(value));
      } else {
        newList.add(value);
      }
    }
    return newList;
  }

  ///Field
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
      _yamlMap[key] as Map<String, dynamic>;
      return true;
    } catch (_) {
      return false;
    }
  }

  ///Get Functions
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

  /// !!!!! Be Careful !!!!!
  /// If the [Type] value is not specified or it is not [Yamlble], an exception is thrown.
  T getYamlble<T>(String key) {
    try {
      return Yamlble.newInstance<T>(_yamlMap[key]);
    } catch (e) {
      rethrow;
    }
  }

  ///Put Functions
  /// If it is not [Yamlble], it is saved using toString() when saving to a file.
  void put(String key, dynamic value) {
    if (value is Yamlble) {
      _yamlMap[key] = value.toYaml();
      return;
    }
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
    return _convertMapString(_yamlMap, 0);
  }

  String _convertMapString(Map<dynamic, dynamic> map, final int order) {
    String string = '';
    String tab = '';
    for (int i = 0; i < order; i++) {
      tab += '  ';
    }

    map.forEach((key, value) {
      //is Map
      if (value is Map<dynamic, dynamic>) {
        string += '$tab$key:\n';
        string += '${_convertMapString(value, order + 1)}\n';
        //is List
      } else if (value is List<dynamic>) {
        string += '$tab$key:\n';
        string += '${_convertListString(value, order + 1)}\n';
        //is Yamlble
      } else if (value is Yamlble) {
        string += '$tab$key:\n';
        string += '${_convertMapString(value.toYaml(), order + 1)}\n';
        //is another
      } else {
        string += '$tab$key: $value\n';
      }

      //delete final line break
      if (map.keys.last == key) {
        final finish = '#%&F&%#';
        string += finish;
        string = string.replaceAll('\n$finish', '');
      }
    });

    return string;
  }

  String _convertListString(List<dynamic> list, final int order) {
    String string = '';
    String tab = '';
    for (int i = 0; i < order; i++) {
      tab += '  ';
    }

    for (var value in list) {
      //is Map
      if (value is Map<dynamic, dynamic>) {
        string += '$tab- $value:\n';
        string += '${_convertMapString(value, order + 1)}\n';
        //is List
      } else if (value is List<dynamic>) {
        string += '$tab- $value:\n';
        string += '${_convertListString(value, order + 1)}\n';
        //is Yamlble
      } else if (value is Yamlble) {
        string += '$tab- $value:\n';
        string += '${_convertMapString(value.toYaml(), order + 1)}\n';
        //is another
      } else {
        string += '$tab- $value\n';
      }

      //delete final line break
      if (list.last == value) {
        final finish = '#%&F&%#';
        string += finish;
        string = string.replaceAll('\n$finish', '');
      }
    }

    return string;
  }
}
