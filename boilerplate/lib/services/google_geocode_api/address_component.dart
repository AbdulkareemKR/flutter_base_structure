class AddressComponent {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'longName': longName,
      'shortName': shortName,
      'types': types,
    };
  }

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map["long_name"],
      shortName: map["short_name"],
      types: map['types'] != null ? List<String>.from((map['types'])) : null,
    );
  }
}
