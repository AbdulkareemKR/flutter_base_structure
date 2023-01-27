import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:garage_client/enums/days.dart';
import 'package:garage_client/enums/repeat_every.dart';
import 'package:garage_client/services/enum_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/services/list_services.dart';

class TimeslotRepeat {
  final String id;
  final String serviceProviderId;
  List<String> technicianIds;
  final List<String> serviceId;
  String? reservedUid;
  final int? techniciansPerOrder;

  String? orderId;
  bool isValid;

  final Timestamp timeFrom;
  final Timestamp timeTo;

  // Repetition fields
  Timestamp nextRun;
  RepeatEvery repeatEvery;
  List<Days> days;

  TimeslotRepeat(
      {required this.id,
      required this.serviceProviderId,
      required this.technicianIds,
      required this.serviceId,
      this.reservedUid,
      this.orderId,
      required this.isValid,
      required this.timeFrom,
      required this.timeTo,
      required this.nextRun,
      required this.repeatEvery,
      required this.days,
      this.techniciansPerOrder});

  TimeslotRepeat copyWith({
    String? id,
    String? serviceProviderId,
    List<String>? technicianIds,
    List<String>? serviceId,
    String? reservedUid,
    bool? isReserved,
    String? orderId,
    bool? isValid,
    Timestamp? timeFrom,
    Timestamp? timeTo,
    Timestamp? nextRun,
    RepeatEvery? repeatEvery,
    List<Days>? days,
    int? techniciansPerOrder,
  }) {
    return TimeslotRepeat(
      id: id ?? this.id,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      technicianIds: technicianIds ?? this.technicianIds,
      serviceId: serviceId ?? this.serviceId,
      reservedUid: reservedUid ?? this.reservedUid,
      orderId: orderId ?? this.orderId,
      isValid: isValid ?? this.isValid,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      nextRun: nextRun ?? this.nextRun,
      repeatEvery: repeatEvery ?? this.repeatEvery,
      days: days ?? this.days,
      techniciansPerOrder: techniciansPerOrder ?? this.techniciansPerOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceProviderId': serviceProviderId,
      'technicianIds': technicianIds,
      'serviceId': serviceId,
      'reservedUid': reservedUid,
      'orderId': orderId,
      'isValid': isValid,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'nextRun': nextRun,
      'repeatEvery': enumToString(repeatEvery),
      'days': enumToList(days),
      'techniciansPerOrder': techniciansPerOrder,
    };
  }

  factory TimeslotRepeat.fromMap(Map<String, dynamic> map) {
    return TimeslotRepeat(
      id: map['id'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      technicianIds: List<String>.from((map['technicianIds'] as List<dynamic>)),
      serviceId: listFromListOrValue(map['serviceId']),
      reservedUid: map['reservedUid'] != null ? map['reservedUid'] as String : null,
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      isValid: map['isValid'] as bool,
      timeFrom: map['timeFrom'] as Timestamp,
      timeTo: map['timeTo'] as Timestamp,
      nextRun: map['nextRun'] as Timestamp,
      repeatEvery: enumFromString(RepeatEvery.values, map['repeatEvery']),
      days: enumFromList(Days.values, map['days']),
      techniciansPerOrder: map['techniciansPerOrder'] ?? 0,
    );
  }

  /// Add technician to technicianIds list.
  void addTechnician(String technicianId) {
    //Check that the technician is not already in the list
    if (!technicianIds.contains(technicianId)) {
      technicianIds.add(technicianId);
    }
  }

  Map<String, dynamic> toUpdateMap() {
    return <String, dynamic>{
      'id': id,
      'technicianIds': technicianIds,
      'serviceId': serviceId,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'repeatEvery': enumToString(repeatEvery),
      'days': enumToList(days),
      'techniciansPerOrder': techniciansPerOrder,
    };
  }

  String toJson() => json.encode(toMap());

  factory TimeslotRepeat.fromJson(String source) => TimeslotRepeat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepeatTimeslot(id: $id, serviceProviderId: $serviceProviderId, technicianIds: $technicianIds, serviceId: $serviceId, reservedUid: $reservedUid, orderId: $orderId, isValid: $isValid, timeFrom: $timeFrom, timeTo: $timeTo, nextRun: $nextRun, repeatEvery: $repeatEvery, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TimeslotRepeat &&
        other.id == id &&
        other.serviceProviderId == serviceProviderId &&
        listEquals(other.technicianIds, technicianIds) &&
        other.serviceId == serviceId &&
        other.reservedUid == reservedUid &&
        other.orderId == orderId &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.nextRun == nextRun &&
        other.repeatEvery == repeatEvery &&
        listEquals(other.days, days);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceProviderId.hashCode ^
        technicianIds.hashCode ^
        serviceId.hashCode ^
        reservedUid.hashCode ^
        orderId.hashCode ^
        isValid.hashCode ^
        timeFrom.hashCode ^
        timeTo.hashCode ^
        nextRun.hashCode ^
        repeatEvery.hashCode ^
        days.hashCode;
  }
}
