import 'dart:convert';

class PriceRange {
  double min;
  double max;
  PriceRange({
    required this.min,
    required this.max,
  });

  PriceRange copyWith({
    double? min,
    double? max,
  }) {
    return PriceRange(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'min': min,
      'max': max,
    };
  }

  factory PriceRange.fromMap(Map<String, dynamic> map) {
    return PriceRange(
      min: map['min'].toDouble() as double,
      max: map['max'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceRange.fromJson(String source) => PriceRange.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PriceRange(min: $min, max: $max)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceRange && 
    other.min == min && 
    other.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;
}
