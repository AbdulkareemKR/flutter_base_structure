import 'dart:convert';

import 'package:garage_core/models/translatable.dart';

class BankInfo {
  String name;
  String iban;
  Translatable bankName;
  BankInfo({
    required this.name,
    required this.iban,
    required this.bankName,
  });

  BankInfo copyWith({
    String? name,
    String? iban,
    Translatable? bankName,
  }) {
    return BankInfo(
      name: name ?? this.name,
      iban: iban ?? this.iban,
      bankName: bankName ?? this.bankName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'iban': iban,
      'bankName': bankName.toMap(),
    };
  }

  factory BankInfo.fromMap(Map<String, dynamic> map) {
    return BankInfo(
      name: map['name'] as String,
      iban: map['iban'] as String,
      bankName: Translatable.fromMap(map['bankName'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory BankInfo.fromJson(String source) => BankInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BankInfo(name: $name, iban: $iban, bankName: $bankName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankInfo && other.name == name && other.iban == iban && other.bankName == bankName;
  }

  @override
  int get hashCode => name.hashCode ^ iban.hashCode ^ bankName.hashCode;
}
