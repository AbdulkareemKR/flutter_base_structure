import 'package:garage_client/global_services/models/exportable.dart';

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
