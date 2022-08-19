This is just a packages that lets me use YamlMap in a way I'm comfortable with.

---
## Usage

> #### [YamlConfiguration](example/example.dart)
```dart
import 'package:utility_yaml/utility_yaml.dart';

main() {
  final yaml = YamlConfiguration.loadPath('example/config.yml');
  print(yaml.getString('string'));
  print(yaml.getInt('int'));
  print(yaml.getDouble('double'));
  print(yaml.getBoolean('boolean'));
  print(yaml.getList('list'));
  print(yaml.getMap('map'));

  yaml.put('copy', [1, 2, 3, 4, 5]);

  yaml.saveToPath('example/configCopy.yml');
}
```

> #### [Yamlble](example/yamlble_example.dart)
```dart
import 'package:utility_yaml/filtering.dart';
import 'package:utility_yaml/yaml_configuration.dart';
import 'package:utility_yaml/yamlble.dart';

main() {
  final path = 'example/yamlbleTest.yml';
  final key = 'yamlble';

  final yaml1 = YamlConfiguration();
  yaml1.put(key, TestYamlbleA());
  yaml1.saveToPath(path);

  final yaml2 = YamlConfiguration.loadPath(path);
  final yamlble = yaml2.getYamlble<TestYamlbleA>(key);

  print('isYamlble: ${yamlble is Yamlble}');
  print('');
  print(yamlble.toString().replaceAll(', ', ', \n'));
}

class TestYamlbleA extends Yamlble {
  TestYamlbleA() {
    b = false;
    i = 123;
    d = 3.14;
    string = 'My name is TestYamlbleA!';
    yamlble = TestYamlbleB();
  }

  TestYamlbleA.loadYaml(this.b, this.i, this.d, this.string, this.yamlble);

  late final bool b;
  late final int i;
  late final double d;
  late final String string;
  late final TestYamlbleB yamlble;
}

class TestYamlbleB extends Yamlble {
  TestYamlbleB() {
    b = true;
    stringList = [
      'This',
      'class',
      'is',
      'TestYamlbleB!',
    ];
    intMap = {
      'aaa': 123,
      'bbb': 456,
      'ccc': 789,
    };
  }

  TestYamlbleB.loadYaml(this.b, List stringList, Map intMap) {
    this.stringList = filteringList<String>(stringList);
    this.intMap = filteringMap<String, int>(intMap);
  }

  late final bool b;
  late final List<String> stringList;
  late final Map<String, int> intMap;
}
```