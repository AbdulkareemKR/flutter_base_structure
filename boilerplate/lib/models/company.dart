import 'dart:convert';

import 'package:collection/collection.dart';

class Company {
  final String id;
  final List<String> branchesIds;
  Company({
    required this.id,
    required this.branchesIds,
  });

  Company copyWith({
    String? id,
    List<String>? branchesIds,
  }) {
    return Company(
      id: id ?? this.id,
      branchesIds: branchesIds ?? this.branchesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'branchesIds': branchesIds,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      branchesIds: map['branchesIds'] as List<String>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Company(id: $id, branchesIds: $branchesIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Company && other.id == id && listEquals(other.branchesIds, branchesIds);
  }

  @override
  int get hashCode => id.hashCode ^ branchesIds.hashCode;
}
