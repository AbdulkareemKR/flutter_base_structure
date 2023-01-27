import 'package:garage_client/models/exportable.dart';
import 'package:garage_client/utils/logger/extensions.dart';

/// Get a list of maps for the class that implement  [Exportable]
List<Map<String, dynamic>> toListOfMap(List<Exportable> exportableList) {
  final List<Map<String, dynamic>> exportableMapList = [];
  for (final exportable in exportableList) {
    exportableMapList.add(exportable.toMap());
  }
  return exportableMapList;
}

/// Get a list of objects by passing a list of maps.
List<T> fromListOfMap<T>(T Function(Map<String, dynamic>) fromMap, List<dynamic> objectsMaps) {
  final List<T> objectsList = [];
  for (final map in objectsMaps) {
    objectsList.add(fromMap(map));
  }
  return objectsList;
}

/// This function will return the value as is if it was a list
/// or it will return a list with one element if it was not a list
List<T> listFromListOrValue<T>(dynamic value) {
  try {
    if (value is List) {
      return value.map((item) => item as T).toList();
    } else {
      return [value];
    }
  } catch (e) {
    e.logException();
    rethrow;
  }
}
