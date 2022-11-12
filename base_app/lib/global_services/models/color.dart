import 'dart:convert';

import 'package:garage_core/models/translatable.dart';

class CarColor {
  final Translatable title;
  final String hexCode;
  CarColor({
    required this.title,
    required this.hexCode,
  });

  CarColor copyWith({
    Translatable? title,
    String? hexCode,
  }) {
    return CarColor(
      title: title ?? this.title,
      hexCode: hexCode ?? this.hexCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title.toMap(),
      'hexCode': hexCode,
    };
  }

  factory CarColor.fromMap(Map<String, dynamic> map) {
    return CarColor(
      title: Translatable.fromMap(map['title']),
      hexCode: map['hexCode'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CarColor.fromJson(String source) => CarColor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Color(title: $title, hexCode: $hexCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarColor && other.title == title && other.hexCode == hexCode;
  }

  @override
  int get hashCode => title.hashCode ^ hexCode.hashCode;
}
