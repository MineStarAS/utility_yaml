This is just a packages that lets me use YamlMap in a way I'm comfortable with.

---
## Usage

You need a [Yaml](https://pub.dev/packages/yaml) package to use it.

```dart
main() {
  final file = File('assets/config.yml');
  final yaml = YamlConfiguration.loadFile(file);

  yaml.put('language', 'en');

  yaml.save(file);
}
```