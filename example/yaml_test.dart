import 'dart:mirrors';

import 'package:utility_yaml/yamlConfiguration.dart';
import 'package:utility_yaml/yamlble.dart';

main() {

  final testPath = 'example/test.yml';

  final test = TestClass();

  final yaml1 = YamlConfiguration();

  yaml1.put('key', test.toYaml());

  yaml1.saveToPath(testPath);

  final yaml2 = YamlConfiguration.loadPath(testPath);

  final map = yaml2.getMap('key');

  Yamlble.newInstance<TestClass>(map!);
}

class TestClass extends Yamlble {
  TestClass() {
    b = false;
    i = 123;
    d = 123.456;
    string = 'test!';
    stringList = ['this', 'is', 'testClass!'];
    intMap = {'a': 111, 'b': 222, 'c': 333};
  }

  TestClass.loadYaml(this.b, this.i, this.d, this.string,this.stringList, this.intMap);

  late final bool b;
  late final int i;
  late final double d;
  late final String string;
  late final List<String> stringList;
  late final Map<String, int> intMap;
}
