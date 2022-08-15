/// Convert Map<dynamic, dynamic> to Map<K, V>.
/// Key and Value that do not match are excluded.
Map<K, V> filteringMap<K, V> (Map<dynamic, dynamic> map) {
  final newMap = <K, V>{};

  map.forEach((key, value) {
    if (key is K && value is V) {
      newMap[key] = value;
    }
  });

  return newMap;
}

/// Convert Map<dynamic, dynamic> to Map<K, V>.
/// Element that do not match are excluded.
List<E> filteringList<E> (List<dynamic> list) {
  final newList = <E>[];

  for (final element in list) {
    if (element is! E) continue;
    newList.add(element);
  }

  return newList;
}