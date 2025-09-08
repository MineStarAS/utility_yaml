import 'package:utility_yaml/utility_yaml.dart';

main() {
  final yaml = YamlConfiguration.loadPath('example/config.yml');
  print(yaml.getString('string'));
  print(yaml.getInt('int'));
  print(yaml.getDouble('double'));
  print(yaml.getBoolean('boolean'));
  print(yaml.getList('list'));
  print(yaml.getMap('map'));

  yaml.saveToPath('example/configCopy.yml');
}
