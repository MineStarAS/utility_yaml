import 'dart:mirrors';

///This abstract class allows conversion to a form that can be stored in a Yaml file.
abstract class Yamlble {
  /// !!!!! WARNING !!!!!
  /// To use this function, the Yamlble class requires a constructor function called 'loadYaml'.
  ///
  /// This function allows you to new instance a Yamlble class stored in Yaml.
  static T newInstance<T>(Map yamlMap) {
    List<ParameterMirror> constructorParameters(ClassMirror classMirror) {
      final constructorMirror = classMirror.declarations[Symbol('$T.loadYaml')];

      if (constructorMirror == null) {
        throw Exception('\'$T\' is not have \'loadYaml\' from constructor.');
      }
      if (constructorMirror is! MethodMirror) {
        throw Exception('\'$T.loadYaml\' is not \'MethodMirror\'.');
      }

      return (constructorMirror).parameters;
    }

    if (T.toString() == 'dynamic') {
      throw Exception('\'Type\' is missing or \'dynamic\'.\n'
          'Usage: Yamlble.newInstance<Type>(yamlMap)');
    }

    if (T.toString() != yamlMap['=='].toString()) throw Exception('\'yamlMap\' is not have \'==\' value.');

    final classMirror = reflectClass(T);

    final List<dynamic> valueList = [];

    for (final parameter in constructorParameters(classMirror)) {
      final symbol = parameter.simpleName;
      final symbolKey = symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');

      final value = yamlMap[symbolKey];
      if (value == null) {
        throw Exception('\'yamlMap\' is not have \'$symbolKey\' value.');
      }

      if (value is Map && value.containsKey('==')) {
        final type = parameter.type.reflectedType;
        valueList.add(Yamlble._newInstance(type, value));
        continue;
      }

      valueList.add(value);
    }

    final T newInstance;
    try {
      newInstance = classMirror.newInstance(Symbol('loadYaml'), valueList).reflectee;
    } catch (e) {
      rethrow;
    }

    return newInstance;
  }

  /// Used when a Yamlble class is required for
  /// the constructor function of the Yamlble class in [newInstance].
  static dynamic _newInstance(Type type, Map yamlMap) {
    List<ParameterMirror> constructorParameters(ClassMirror classMirror) {
      final constructorMirror = classMirror.declarations[Symbol('$type.loadYaml')];

      if (constructorMirror == null) throw Exception('\'$type\' is not have \'loadYaml\' from constructor.');
      if (constructorMirror is! MethodMirror) throw Exception('\'$type.loadYaml\' is not \'MethodMirror\'.');

      return (constructorMirror).parameters;
    }

    if ('$type' != yamlMap['=='].toString()) throw Exception('\'yamlMap\' is not have \'==\' value.');

    final classMirror = reflectClass(type);

    final List<dynamic> valueList = [];

    for (final parameter in constructorParameters(classMirror)) {
      final symbol = parameter.simpleName;
      final symbolKey = symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');

      final value = yamlMap[symbolKey];
      if (value == null) throw Exception('\'yamlMap\' is not have \'$symbolKey\' value.');

      if (value is Map && value.containsKey('==')) {
        final type = parameter.type.reflectedType;
        valueList.add(Yamlble._newInstance(type, value));
        continue;
      }

      valueList.add(value);
    }

    final dynamic newInstance;
    try {
      newInstance = classMirror.newInstance(Symbol('loadYaml'), valueList).reflectee;
    } catch (e) {
      rethrow;
    }

    return newInstance;
  }

  ///Convert to a [Map] format that can be stored in a Yaml file.
  Map<String, dynamic> toYaml() {
    final map = <String, dynamic>{};

    final classMirror = reflectClass(runtimeType);
    final instanceMirror = reflect(this);

    map['=='] = runtimeType;

    for (final symbol in _constructorParameterSymbols(classMirror)) {
      final symbolKey = symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');

      final mirror = classMirror.declarations[symbol];
      if (mirror == null) throw throw Exception('\'$runtimeType\' is not have \'$symbolKey\' from field.');

      map[symbolKey] = instanceMirror.getField(symbol).reflectee;
    }

    return map;
  }

  List<Symbol> _constructorParameterSymbols(ClassMirror classMirror) {
    final parameters = <Symbol>[];
    final constructorMirror = classMirror.declarations[Symbol('$runtimeType.loadYaml')];

    if (constructorMirror == null) throw Exception('\'$runtimeType\' is not have \'loadYaml\' from constructor.');
    if (constructorMirror is! MethodMirror) throw Exception('\'$runtimeType.loadYaml\' is not \'MethodMirror\'.');

    for (final parameter in (constructorMirror).parameters) {
      parameters.add(parameter.simpleName);
    }

    return parameters;
  }

  @override
  String toString() {
    return toYaml().toString();
  }
}
