import 'dart:convert';

class Translatable {
  String ar;
  String en;
  Translatable({
    required this.ar,
    required this.en,
  });

  Translatable copyWith({
    String? ar,
    String? en,
  }) {
    return Translatable(
      ar: ar ?? this.ar,
      en: en ?? this.en,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ar': ar,
      'en': en,
    };
  }

  factory Translatable.fromMap(Map<String, dynamic> map) {
    return Translatable(
      ar: map['ar'] != null ? map['ar'] as String : map['en'] as String,
      en: map['en'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Translatable.fromJson(String source) => Translatable.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Translatable(ar: $ar, en: $en)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Translatable && other.ar == ar && other.en == en;
  }

  @override
  int get hashCode => ar.hashCode ^ en.hashCode;
}
