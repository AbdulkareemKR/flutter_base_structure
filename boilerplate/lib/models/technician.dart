import "dart:convert";
import 'package:garage_client/enums/technician_status.dart';
import 'package:garage_client/services/enum_services.dart';
export 'package:garage_client/enums/technician_status.dart';

class Technician {
  String uid;
  String serviceProviderId;
  String name;
  String username;
  // by default it is off.
  // if the technician is available, it will be set to available.
  // if the technician is busy, it will be set to busy.
  TechnicianStatus status;
  String email;
  int hasWorked = 0;
  final bool isDeleted;

  Technician({
    required this.uid,
    required this.serviceProviderId,
    required this.name,
    required this.email,
    required this.hasWorked,
    required this.username,
    required this.status,
    this.isDeleted = false,
  });

  Technician copyWith({
    String? uid,
    String? serviceProviderId,
    String? name,
    String? email,
    int? hasWorked,
    String? username,
    bool? isDeleted,
    TechnicianStatus? status,
  }) {
    return Technician(
      uid: uid ?? this.uid,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      name: name ?? this.name,
      email: email ?? this.email,
      hasWorked: hasWorked ?? this.hasWorked,
      status: status ?? this.status,
      username: username ?? this.username,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'serviceProviderId': serviceProviderId,
      'name': name,
      'email': email,
      'hasWorked': hasWorked,
      'username': username,
      'status': enumToString(status),
      "isDeleted": isDeleted,
    };
  }

  factory Technician.fromMap(Map<String, dynamic> map) {
    return Technician(
      uid: map['uid'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      hasWorked: map['hasWorked'] as int,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : false,
      username: map['username'] != null ? map['username'] as String : map['name'] as String,
      status: enumFromString<TechnicianStatus>(TechnicianStatus.values, map['status'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Technician.fromJson(String source) => Technician.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Technician(uid: $uid, serviceProviderId: $serviceProviderId, name: $name, email: $email, hasWorked: $hasWorked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Technician &&
        other.uid == uid &&
        other.serviceProviderId == serviceProviderId &&
        other.name == name &&
        other.email == email &&
        other.username == username &&
        other.hasWorked == hasWorked;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ serviceProviderId.hashCode ^ name.hashCode ^ email.hashCode ^ hasWorked.hashCode;
  }
}
