import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:garage_client/models/exportable.dart';
import 'package:garage_client/models/translatable.dart';

class Bank implements Exportable {
  final String id;
  final Translatable bankName;
  Bank({
    required this.id,
    required this.bankName,
  });

  Bank copyWith({
    String? id,
    Translatable? bankName,
  }) {
    return Bank(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bankName': bankName.toMap(),
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] as String,
      bankName: Translatable.fromMap(map['bankName'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Bank(id: $id, bankName: $bankName';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Bank && other.id == id && other.bankName == bankName;
  }

  @override
  int get hashCode => id.hashCode ^ bankName.hashCode;
}
