import 'dart:convert';

import 'package:garage_client/global_services/enums/user_type.dart';
import 'package:garage_client/global_services/services/enum_services.dart';
export 'package:garage_client/global_services/enums/user_type.dart';

class OrderRate {
  String uid;
  int rate;
  String comment;
  UserType userType;
  OrderRate({
    required this.uid,
    required this.rate,
    required this.comment,
    required this.userType,
  });

  OrderRate copyWith({
    String? uid,
    int? rate,
    String? comment,
    UserType? userType,
  }) {
    return OrderRate(
      uid: uid ?? this.uid,
      rate: rate ?? this.rate,
      comment: comment ?? this.comment,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'rate': rate,
      'comment': comment,
      'userType': enumToString(userType),
    };
  }

  factory OrderRate.fromMap(Map<String, dynamic> map) {
    return OrderRate(
      uid: map['uid'] as String,
      rate: map['rate'] as int,
      comment: map['comment'] as String,
      userType: enumFromString(UserType.values, map['userType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRate.fromJson(String source) => OrderRate.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<OrderRate> orderRateListFromMap(List<Map<String, dynamic>>? orderRateData) {
    if (orderRateData == null) return [];
    final orderRate = List<OrderRate>.from((orderRateData).map<OrderRate>(
      (order) => OrderRate.fromMap(order),
    ));
    return orderRate;
  }

  @override
  String toString() {
    return 'OrderRate(uid: $uid, rate: $rate, comment: $comment, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderRate &&
        other.uid == uid &&
        other.rate == rate &&
        other.comment == comment &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ rate.hashCode ^ comment.hashCode ^ userType.hashCode;
  }
}
