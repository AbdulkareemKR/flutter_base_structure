import 'dart:convert';

import 'package:collection/collection.dart';

class ServiceProviderExcluding {
  // car owner id
  final String uid;
  // list contains service services providers ids
  // that are excluded from the car owner
  // excluded means that the car owner will not see them in the app
  final List<String> serviceProviderIds;
  ServiceProviderExcluding({
    required this.uid,
    required this.serviceProviderIds,
  });

  ServiceProviderExcluding copyWith({
    String? uid,
    List<String>? serviceProviderIds,
  }) {
    return ServiceProviderExcluding(
      uid: uid ?? this.uid,
      serviceProviderIds: serviceProviderIds ?? this.serviceProviderIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'serviceProviderIds': serviceProviderIds,
    };
  }

  factory ServiceProviderExcluding.fromMap(Map<String, dynamic> map) {
    return ServiceProviderExcluding(
      uid: map['uid'] as String,
      serviceProviderIds: map['serviceProviderIds'] as List<String>,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceProviderExcluding.fromJson(String source) =>
      ServiceProviderExcluding.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceProviderExcluding(uid: $uid, serviceProviderIds: $serviceProviderIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ServiceProviderExcluding &&
        other.uid == uid &&
        listEquals(other.serviceProviderIds, serviceProviderIds);
  }

  @override
  int get hashCode => uid.hashCode ^ serviceProviderIds.hashCode;
}
