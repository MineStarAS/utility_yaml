import 'package:utility_yaml/yaml_configuration.dart';

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
