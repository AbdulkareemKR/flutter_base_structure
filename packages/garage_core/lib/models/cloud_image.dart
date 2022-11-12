import 'dart:convert';

class CloudImage {
  final String hash;
  final String small;
  final String medium;
  final String high;
  final String full;
  CloudImage({
    required this.hash,
    required this.small,
    required this.medium,
    required this.high,
    required this.full,
  });

  CloudImage copyWith({
    String? hash,
    String? small,
    String? medium,
    String? high,
    String? full,
  }) {
    return CloudImage(
      hash: hash ?? this.hash,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      high: high ?? this.high,
      full: full ?? this.full,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'small': small,
      'medium': medium,
      'high': high,
      'full': full,
    };
  }

  factory CloudImage.fromMap(Map<String, dynamic> map) {
    return CloudImage(
      hash: map['hash'] as String,
      small: map['small'] as String,
      medium: map['medium'] as String,
      high: map['high'] as String,
      full: map['full'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudImage.fromJson(String source) => CloudImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CloudImage(hash: $hash, small: $small, medium: $medium, high: $high, full: $full)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CloudImage &&
        other.hash == hash &&
        other.small == small &&
        other.medium == medium &&
        other.high == high &&
        other.full == full;
  }

  @override
  int get hashCode {
    return hash.hashCode ^ small.hashCode ^ medium.hashCode ^ high.hashCode ^ full.hashCode;
  }

}
