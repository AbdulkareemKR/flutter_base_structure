import 'dart:convert';

class Notification {
  final String uid;
  final String id;
  final String message;
  final String fcmToken;
  Notification({
    required this.uid,
    required this.id,
    required this.message,
    required this.fcmToken,
  });

  Notification copyWith({
    String? uid,
    String? id,
    String? message,
    String? fcmToken,
  }) {
    return Notification(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      message: message ?? this.message,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': id,
      'message': message,
      'fcmToken': fcmToken,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      uid: map['uid'] as String,
      id: map['id'] as String,
      message: map['message'] as String,
      fcmToken: map['fcmToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(uid: $uid, id: $id, message: $message, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Notification &&
      other.uid == uid &&
      other.id == id &&
      other.message == message &&
      other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      id.hashCode ^
      message.hashCode ^
      fcmToken.hashCode;
  }
}
