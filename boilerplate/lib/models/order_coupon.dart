import 'dart:convert';

class OrderCoupon {
  String id;
  String code;
  String? issuerId;
  double? discountAmount;
  double? discountPercentage;
  OrderCoupon({
    required this.id,
    required this.code,
    this.issuerId,
    this.discountAmount,
    this.discountPercentage,
  });

  OrderCoupon copyWith({
    String? id,
    String? code,
    String? issuerId,
    double? discountAmount,
    double? discountPercentage,
  }) {
    return OrderCoupon(
      id: id ?? this.id,
      code: code ?? this.code,
      issuerId: issuerId ?? this.issuerId,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'issuerId': issuerId,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
    };
  }

  factory OrderCoupon.fromMap(Map<String, dynamic> map) {
    return OrderCoupon(
      id: map['id'] as String,
      code: map['code'] as String,
      issuerId: map['issuerId'] != null ? map['issuerId'] as String : null,
      discountAmount: map['discountAmount'] != null
          ? map['discountAmount'] as double
          : null,
      discountPercentage: map['discountPercentage'] != null
          ? map['discountPercentage'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCoupon.fromJson(String source) =>
      OrderCoupon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderCoupon(id: $id, code: $code, issuerId: $issuerId, discountAmount: $discountAmount, discountPercentage: $discountPercentage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderCoupon &&
        other.id == id &&
        other.code == code &&
        other.issuerId == issuerId &&
        other.discountAmount == discountAmount &&
        other.discountPercentage == discountPercentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        issuerId.hashCode ^
        discountAmount.hashCode ^
        discountPercentage.hashCode;
  }
}
