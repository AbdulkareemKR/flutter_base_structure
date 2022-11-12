// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDates {
  DateTime orderDate;
  DateTime? acceptanceDate;
  DateTime? checkinDate;
  DateTime? checkoutDate;
  DateTime? nearCustomerDate;
  DateTime? rejectDate;
  DateTime? expectedArrivalDate;
  DateTime? deleteDate;
  DateTime? cancelDate;

  OrderDates({
    required this.orderDate,
    this.acceptanceDate,
    this.checkinDate,
    this.checkoutDate,
    this.nearCustomerDate,
    this.expectedArrivalDate,
    this.cancelDate,
    this.deleteDate,
    this.rejectDate,
  });

  OrderDates copyWith({
    DateTime? orderDate,
    DateTime? acceptanceDate,
    DateTime? checkinDate,
    DateTime? checkoutDate,
    DateTime? nearCustomerDate,
    DateTime? expectedArrivalDate,
    DateTime? cancelDate,
    DateTime? deleteDate,
    DateTime? rejectDate,
  }) {
    return OrderDates(
      orderDate: orderDate ?? this.orderDate,
      acceptanceDate: acceptanceDate ?? this.acceptanceDate,
      checkinDate: checkinDate ?? this.checkinDate,
      checkoutDate: checkoutDate ?? this.checkoutDate,
      nearCustomerDate: nearCustomerDate ?? this.nearCustomerDate,
      expectedArrivalDate: expectedArrivalDate ?? this.expectedArrivalDate,
      cancelDate: cancelDate ?? this.cancelDate,
      deleteDate: deleteDate ?? this.deleteDate,
      rejectDate: rejectDate ?? this.rejectDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderDate': orderDate,
      'acceptanceDate': acceptanceDate,
      'checkinDate': checkinDate,
      'checkoutDate': checkoutDate,
      'nearCustomerDate': nearCustomerDate,
      'expectedArrivalDate': expectedArrivalDate,
      'cancelDate': cancelDate,
      'deleteDate': deleteDate,
      'rejectDate': rejectDate,
    };
  }

  static checkDateType(dynamic date) {
    return date is Timestamp ? date.toDate() : date as DateTime;
  }

  factory OrderDates.fromMap(Map<String, dynamic> map) {
    return OrderDates(
      orderDate: checkDateType(map['orderDate']),
      acceptanceDate: map['acceptanceDate'] != null ? checkDateType(map['acceptanceDate']) : null,
      checkinDate: map['checkinDate'] != null ? checkDateType(map['checkinDate']) : null,
      checkoutDate: map['checkoutDate'] != null ? checkDateType(map['checkoutDate']) : null,
      nearCustomerDate: map['nearCustomerDate'] != null ? checkDateType(map['nearCustomerDate']) : null,
      expectedArrivalDate: map['expectedArrivalDate'] != null ? checkDateType(map['expectedArrivalDate']) : null,
      cancelDate: map['cancelDate'] != null ? checkDateType(map['cancelDate']) : null,
      deleteDate: map['deleteDate'] != null ? checkDateType(map['deleteDate']) : null,
      rejectDate: map['rejectDate'] != null ? checkDateType(map['rejectDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDates.fromJson(String source) => OrderDates.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderDates(orderDate: $orderDate, acceptanceDate: $acceptanceDate, checkinDate: $checkinDate, checkoutDate: $checkoutDate, nearCustomerDate: $nearCustomerDate, expectedArrivalDate: $expectedArrivalDate, cancelDate: $cancelDate, deleteDate: $deleteDate, rejectDate: $rejectDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDates &&
        other.orderDate == orderDate &&
        other.acceptanceDate == acceptanceDate &&
        other.checkinDate == checkinDate &&
        other.checkoutDate == checkoutDate &&
        other.nearCustomerDate == nearCustomerDate &&
        other.expectedArrivalDate == expectedArrivalDate &&
        other.cancelDate == cancelDate &&
        other.deleteDate == deleteDate &&
        other.rejectDate == rejectDate;
  }

  @override
  int get hashCode {
    return orderDate.hashCode ^
        acceptanceDate.hashCode ^
        checkinDate.hashCode ^
        checkoutDate.hashCode ^
        nearCustomerDate.hashCode ^
        expectedArrivalDate.hashCode ^
        cancelDate.hashCode ^
        deleteDate.hashCode ^
        rejectDate.hashCode;
  }
}
