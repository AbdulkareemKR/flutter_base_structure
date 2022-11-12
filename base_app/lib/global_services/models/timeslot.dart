import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:garage_core/models/flutter_timestamp.dart';

class Timeslot {
  // Basic info
  final String id;
  final String serviceProviderId;
  List<String> technicianIds;
  final String serviceId;
  String? reservedUid;
  bool isReserved;
  String? orderId;
  bool isValid;

  // Duration fields
  final Timestamp dateFrom;
  final Timestamp dateTo;

  // Repeat Related fields
  bool isRepeated;
  String? repeatedId;

  Timeslot({
    required this.id,
    required this.serviceProviderId,
    required this.technicianIds,
    required this.serviceId,
    required this.dateFrom,
    required this.dateTo,
    this.reservedUid,
    required this.isReserved,
    this.orderId,
    required this.isValid,
    required this.isRepeated,
    this.repeatedId,
  });

  Timeslot copyWith({
    String? id,
    String? serviceProviderId,
    List<String>? technicianIds,
    String? serviceId,
    Timestamp? dateFrom,
    Timestamp? dateTo,
    String? reservedUid,
    bool? isReserved,
    String? orderId,
    bool? isValid,
    bool? isRepeated,
    String? repeatedId,
  }) {
    return Timeslot(
      id: id ?? this.id,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      technicianIds: technicianIds ?? this.technicianIds,
      serviceId: serviceId ?? this.serviceId,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      reservedUid: reservedUid ?? this.reservedUid,
      isReserved: isReserved ?? this.isReserved,
      orderId: orderId ?? this.orderId,
      isValid: isValid ?? this.isValid,
      isRepeated: isRepeated ?? this.isRepeated,
      repeatedId: repeatedId ?? this.repeatedId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceProviderId': serviceProviderId,
      'technicianIds': technicianIds,
      'serviceId': serviceId,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'reservedUid': reservedUid,
      'isReserved': isReserved,
      'orderId': orderId,
      'isValid': isValid,
      'isRepeated': isRepeated,
      'repeatedId': repeatedId,
    };
  }

  Map<String, dynamic> toCallableRequest() {
    return <String, dynamic>{
      'id': id,
      'serviceProviderId': serviceProviderId,
      'technicianIds': technicianIds,
      'serviceId': serviceId,
      'dateFrom': FlutterTimestamp.toMap(dateFrom),
      'dateTo': FlutterTimestamp.toMap(dateTo),
      'reservedUid': reservedUid,
      'isReserved': isReserved,
      'orderId': orderId,
      'isValid': isValid,
      'isRepeated': isRepeated,
      'repeatedId': repeatedId,
    };
  }

  factory Timeslot.fromMap(Map<String, dynamic> map) {
    return Timeslot(
      id: map['id'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      technicianIds: List<String>.from((map['technicianIds'] as List<dynamic>)),
      serviceId: map['serviceId'] as String,
      dateFrom: FlutterTimestamp.parse(map['dateFrom']),
      dateTo: FlutterTimestamp.parse(map['dateTo']),
      reservedUid: map['reservedUid'] != null ? map['reservedUid'] as String : null,
      isReserved: map['isReserved'] as bool,
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      isValid: map['isValid'] as bool,
      isRepeated: map['isRepeated'] as bool,
      repeatedId: map['repeatedId'] != null ? map['repeatedId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timeslot.fromJson(String source) => Timeslot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Timeslot(id: $id, serviceProviderId: $serviceProviderId, technicianIds: $technicianIds, serviceId: $serviceId, dateFrom: $dateFrom, dateTo: $dateTo, reservedUid: $reservedUid, isReserved: $isReserved, orderId: $orderId, isValid: $isValid, isRepeated: $isRepeated, repeatedId: $repeatedId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Timeslot &&
        other.id == id &&
        other.serviceProviderId == serviceProviderId &&
        listEquals(other.technicianIds, technicianIds) &&
        other.serviceId == serviceId &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.reservedUid == reservedUid &&
        other.isReserved == isReserved &&
        other.orderId == orderId &&
        other.isValid == isValid &&
        other.isRepeated == isRepeated &&
        other.repeatedId == repeatedId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceProviderId.hashCode ^
        technicianIds.hashCode ^
        serviceId.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        reservedUid.hashCode ^
        isReserved.hashCode ^
        orderId.hashCode ^
        isValid.hashCode ^
        isRepeated.hashCode ^
        repeatedId.hashCode;
  }
}
