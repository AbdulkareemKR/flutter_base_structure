import 'dart:convert';

import "package:garage_client/enums/complaint_status.dart";
import 'package:garage_client/enums/complaint_type.dart';
import 'package:garage_client/services/enum_services.dart';
export 'package:garage_client/enums/complaint_type.dart';
export "package:garage_client/enums/complaint_status.dart";

class Complaints {
  String id;
  String? uid;
  String title;
  String body;
  String resolution;
  ComplaintType type;
  ComplaintStatus status;
  Complaints({
    required this.id,
    this.uid,
    required this.title,
    required this.body,
    required this.resolution,
    required this.type,
    required this.status,
  });

  Complaints copyWith({
    String? id,
    String? uid,
    String? title,
    String? body,
    String? resolution,
    ComplaintType? type,
    ComplaintStatus? status,
  }) {
    return Complaints(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      body: body ?? this.body,
      resolution: resolution ?? this.resolution,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'body': body,
      'resolution': resolution,
      'type': enumToString(type),
      'status': enumToString(status),
    };
  }

  factory Complaints.fromMap(Map<String, dynamic> map) {
    return Complaints(
      id: map['id'] as String,
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] as String,
      body: map['body'] as String,
      resolution: map['resolution'] as String,
      type: enumFromString<ComplaintType>(ComplaintType.values, map["type"]),
      status: enumFromString<ComplaintStatus>(
          ComplaintStatus.values, map['status'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Complaints.fromJson(String source) =>
      Complaints.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Complaints(id: $id, uid: $uid, title: $title, body: $body, resolution: $resolution, type: $type, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complaints &&
        other.id == id &&
        other.uid == uid &&
        other.title == title &&
        other.body == body &&
        other.resolution == resolution &&
        other.type == type &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        title.hashCode ^
        body.hashCode ^
        resolution.hashCode ^
        type.hashCode ^
        status.hashCode;
  }
}
