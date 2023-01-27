import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:garage_client/enums/gift_type.dart';
import 'package:garage_client/models/transaction.dart';
import 'package:garage_client/services/enum_services.dart';
import 'package:http/http.dart';
export 'package:garage_client/enums/gift_type.dart';

class GiftCard {
  final String? id;
  final String? code;

  // The basic info about the gift
  String issuerId;
  String? usedById;
  bool isUsed;
  Timestamp? expirationDate;

  // These two field used to send the gift to the other, by the app or by SMS
  String? sentToId;
  String sentToPhoneNumber;

  // The type of the gift either money of service
  GiftType type;

  // either the amount or (serviceId and serviceProviderId) will be null depends on the GiftType
  String? serviceId;
  String? serviceProviderId;
  double? amount;
  Transaction transaction;

  GiftCard({
    this.id,
    this.code,
    required this.issuerId,
    this.usedById,
    required this.isUsed,
    this.expirationDate,
    required this.type,
    required this.transaction,
    required this.sentToPhoneNumber,
    this.sentToId,
    this.serviceId,
    this.serviceProviderId,
    this.amount,
  });

  GiftCard copyWith({
    String? id,
    String? code,
    String? issuerId,
    String? usedById,
    bool? isUsed,
    Timestamp? expirationDate,
    GiftType? type,
    String? serviceId,
    String? serviceProviderId,
    double? amount,
    String? sentToId,
    String? sentToPhoneNumber,
    Transaction? transaction,
  }) {
    return GiftCard(
      id: id ?? this.id,
      code: code ?? this.code,
      issuerId: issuerId ?? this.issuerId,
      usedById: usedById ?? this.usedById,
      isUsed: isUsed ?? this.isUsed,
      expirationDate: expirationDate ?? this.expirationDate,
      type: type ?? this.type,
      serviceId: serviceId ?? this.serviceId,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      amount: amount ?? this.amount,
      sentToId: sentToId ?? this.sentToId,
      sentToPhoneNumber: sentToPhoneNumber ?? this.sentToPhoneNumber,
      transaction: transaction ?? this.transaction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'issuerId': issuerId,
      'usedById': usedById,
      'isUsed': isUsed,
      'expirationDate': expirationDate,
      'type': enumToString(type),
      'serviceId': serviceId,
      'serviceProviderId': serviceProviderId,
      'amount': amount,
      'sentToId': sentToId,
      'sentToPhoneNumber': sentToPhoneNumber,
      'transaction': transaction.toMap(),
    };
  }

  factory GiftCard.fromMap(Map<String, dynamic> map) {
    return GiftCard(
      id: map['id'] != null ? map['id'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      issuerId: map['issuerId'] as String,
      usedById: map['usedById'] != null ? map['usedById'] as String : null,
      isUsed: map['isUsed'] as bool,
      expirationDate: map['expirationDate'] != null ? map['expirationDate'] as Timestamp : null,
      type: enumFromString<GiftType>(GiftType.values, map['type']),
      serviceId: map['serviceId'] != null ? map['serviceId'] as String : null,
      serviceProviderId: map['serviceProviderId'] != null ? map['serviceProviderId'] as String : null,
      amount: map['amount'] != null ? double.parse((map['amount'] as double).toStringAsFixed(2)) : null,
      sentToId: map['sentToId'] != null ? map['sentToId'] as String : null,
      sentToPhoneNumber: map['sentToPhoneNumber'] as String,
      transaction: Transaction.fromMap(map['transaction']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftCard.fromJson(String source) => GiftCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GiftCard(id: $id, code: $code, issuerId: $issuerId, usedById: $usedById, isUsed: $isUsed, expirationDate: $expirationDate, type: $type, serviceId: $serviceId, serviceProviderId: $serviceProviderId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftCard &&
        other.id == id &&
        other.code == code &&
        other.issuerId == issuerId &&
        other.usedById == usedById &&
        other.isUsed == isUsed &&
        other.expirationDate == expirationDate &&
        other.type == type &&
        other.serviceId == serviceId &&
        other.serviceProviderId == serviceProviderId &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        issuerId.hashCode ^
        usedById.hashCode ^
        isUsed.hashCode ^
        expirationDate.hashCode ^
        type.hashCode ^
        serviceId.hashCode ^
        serviceProviderId.hashCode ^
        amount.hashCode;
  }
}
