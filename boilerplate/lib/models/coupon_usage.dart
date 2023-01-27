import 'dart:convert';

class CouponUsage {
  final String uid;
  int usages;
  CouponUsage({
    required this.uid,
    this.usages = 1,
  });

  CouponUsage copyWith({
    String? uid,
    int? usages,
  }) {
    return CouponUsage(
      uid: uid ?? this.uid,
      usages: usages ?? this.usages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'usages': usages,
    };
  }

  factory CouponUsage.fromMap(Map<String, dynamic> map) {
    return CouponUsage(
      uid: map['uid'] as String,
      usages: map['usages'] as int,
    );
  }

  static Map<String, dynamic> toMapFromList(List<CouponUsage> usages) {
    final usagesMap = <String, dynamic>{};

    // Add each usage object to the map as <uid, usages>
    for (final usage in usages) {
      usagesMap[usage.uid] = usage.usages;
    }
    return usagesMap;
  }

  static List<CouponUsage> toListFromMap(Map<String, dynamic> usages) {
    final List<CouponUsage> usagesList = [];

    /// Create a [CouponUsage] for each uid, usage in the map
    usages.forEach((uid, usage) {
    
      usagesList.add(CouponUsage(uid: uid, usages: usage));
    });
    return usagesList;
  }

  String toJson() => json.encode(toMap());

  factory CouponUsage.fromJson(String source) => CouponUsage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CouponUsage(uid: $uid, usages: $usages)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CouponUsage && other.uid == uid && other.usages == usages;
  }

  @override
  int get hashCode => uid.hashCode ^ usages.hashCode;
}
