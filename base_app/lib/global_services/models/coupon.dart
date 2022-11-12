import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:garage_client/global_services/enums/currency.dart';
import 'package:garage_client/global_services/models/coupon_usage.dart';
import 'package:garage_client/global_services/models/flutter_timestamp.dart';
import 'package:garage_client/global_services/services/enum_services.dart';

class Coupon {
  // Basic coupon's info.
  final String id;
  final String code;
  final Timestamp expirationDate;
  final num? discountAmount;
  final num? discountPercentage;
  final Currency? currency;
  bool isValid;

  // Business related info
  final String? issuerId;
  final String? campaign;

  // Usage related fields
  int totalUsage;
  int? usageLimit;
  List<CouponUsage> couponUsage;

  Coupon({
    required this.id,
    required this.code,
    required this.expirationDate,
    required this.discountAmount,
    required this.discountPercentage,
    required this.isValid,
    this.issuerId,
    required this.currency,
    this.campaign,
    required this.totalUsage,
    this.usageLimit,
    required this.couponUsage,
  });

  /// This function will record a usage locally.
  void addUsage(String uid) {
    // TODO: The possess of recording usages should be handled with a backend endpoint    // This method just to add the usage to the data class locally.
    // fist we increment the total usage
    totalUsage = totalUsage + 1;

    final user = couponUsage.firstWhereOrNull((usage) => usage.uid == uid);
    // second we check if the user has used the coupon before.
    if (user != null) {
      // if yes then we increment his usages
      user.usages = user.usages + 1;
    } else {
      // if no then we add a new record with initial value of 1
      // If we didn't pass a usage it will be 1 by default.
      couponUsage.add(CouponUsage(uid: uid));
    }
  }

  Coupon copyWith({
    String? id,
    String? code,
    Timestamp? expirationDate,
    num? discountAmount,
    num? discountPercentage,
    bool? isValid,
    String? issuerId,
    String? campaign,
    int? totalUsage,
    int? usageLimit,
    List<CouponUsage>? couponUsage,
    Currency? currency,
  }) {
    return Coupon(
        id: id ?? this.id,
        code: code ?? this.code,
        expirationDate: expirationDate ?? this.expirationDate,
        discountAmount: discountAmount ?? this.discountAmount,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        isValid: isValid ?? this.isValid,
        issuerId: issuerId ?? this.issuerId,
        campaign: campaign ?? this.campaign,
        totalUsage: totalUsage ?? this.totalUsage,
        usageLimit: usageLimit ?? this.usageLimit,
        couponUsage: couponUsage ?? this.couponUsage,
        currency: currency ?? this.currency);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'expirationDate': FlutterTimestamp.toMap(expirationDate),
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'isValid': isValid,
      'issuerId': issuerId,
      'campaign': campaign,
      'totalUsage': totalUsage,
      'usageLimit': usageLimit,
      'couponUsage': CouponUsage.toMapFromList(couponUsage),
      'currency': enumToString(currency),
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] as String,
      code: map['code'] as String,
      expirationDate: FlutterTimestamp.parse(map['expirationDate']),
      discountAmount: map['discountAmount'] != null ? map['discountAmount'] as double : null,
      discountPercentage: map['discountPercentage'] != null ? map['discountPercentage'] as num : null,
      isValid: map['isValid'] as bool,
      issuerId: map['issuerId'] != null ? map['issuerId'] as String : null,
      campaign: map['campaign'] != null ? map['campaign'] as String : null,
      totalUsage: map['totalUsage'] as int,
      usageLimit: map['usageLimit'] != null ? map['usageLimit'] as int : null,
      couponUsage: CouponUsage.toListFromMap(map['couponUsage'] as Map<String, dynamic>),
      currency: map['currency'] != null ? enumFromString(Currency.values, map['currency'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) => Coupon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coupon(id: $id, code: $code, expirationDate: $expirationDate, discountAmount: $discountAmount, discountPercentage: $discountPercentage, isValid: $isValid, issuerId: $issuerId, campaign: $campaign, totalUsage: $totalUsage, usageLimit: $usageLimit, couponUsage: $couponUsage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is Coupon &&
        other.id == id &&
        other.code == code &&
        other.expirationDate == expirationDate &&
        other.discountAmount == discountAmount &&
        other.discountPercentage == discountPercentage &&
        other.isValid == isValid &&
        other.issuerId == issuerId &&
        other.campaign == campaign &&
        other.totalUsage == totalUsage &&
        other.usageLimit == usageLimit &&
        mapEquals(other.couponUsage, couponUsage);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        expirationDate.hashCode ^
        discountAmount.hashCode ^
        discountPercentage.hashCode ^
        isValid.hashCode ^
        issuerId.hashCode ^
        campaign.hashCode ^
        totalUsage.hashCode ^
        usageLimit.hashCode ^
        couponUsage.hashCode;
  }

  bool get isFixedAmount => discountAmount != null;

  num get amount => isFixedAmount ? discountAmount! : discountPercentage!;

  String get discount {
    final String discountString;
    if (isFixedAmount) {
      discountString = discountAmount!.toStringAsFixed(2) + getEnumReadable(currency, 'ar');
    } else {
      discountString = discountPercentage!.toStringAsFixed(2) + '%';
    }
    return discountString;
  }
}
