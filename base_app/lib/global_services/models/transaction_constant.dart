import 'dart:convert';

class TransactionConstant {
  final num vatPercent;
  TransactionConstant({
    required this.vatPercent,
  });

  TransactionConstant copyWith({
    num? vatPercent,
  }) {
    return TransactionConstant(
      vatPercent: vatPercent ?? this.vatPercent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vatPercent': vatPercent,
    };
  }

  factory TransactionConstant.fromMap(Map<String, dynamic> map) {
    return TransactionConstant(
      vatPercent: map['vatPercent'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionConstant.fromJson(String source) =>
      TransactionConstant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TransactionConstant(vatPercent: $vatPercent)';

  @override
  bool operator ==(covariant TransactionConstant other) {
    if (identical(this, other)) return true;

    return other.vatPercent == vatPercent;
  }

  @override
  int get hashCode => vatPercent.hashCode;

  double getPriceWithVat(double rawPrice) {
    return rawPrice + (rawPrice * vat);
  }

  double get vat => vatPercent / 100;
}
