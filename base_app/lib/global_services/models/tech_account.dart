class TechAccount {
  String uid;
  String serviceProviderId;
  String name;
  String email;
  String password;

  TechAccount({
    required this.uid,
    required this.serviceProviderId,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'serviceProviderId': serviceProviderId,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory TechAccount.fromMap(Map<String, dynamic> map) {
    return TechAccount(
      uid: map["uid"],
      serviceProviderId: map["serviceProviderId"],
      name: map["name"],
      email: map["email"],
      password: map["password"],
    );
  }
}
