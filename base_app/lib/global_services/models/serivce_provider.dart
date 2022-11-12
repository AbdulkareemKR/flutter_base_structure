import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:garage_client/global_services/models/available_service.dart';
import 'package:garage_client/global_services/models/bank_info.dart';
import 'package:garage_client/global_services/models/city.dart';
import 'package:garage_client/global_services/models/cloud_image.dart';
import 'package:garage_client/global_services/models/location.dart';
import 'package:garage_client/global_services/models/translatable.dart';
import 'package:garage_client/global_services/enums/service_status.dart';
import 'package:garage_client/global_services/services/enum_services.dart';
import 'package:garage_client/global_services/services/list_services.dart';
import '../enums/service_type.dart';

export 'package:garage_client/global_services/enums/service_status.dart';
export '../enums/service_type.dart';

class ServiceProvider {
// basic SP info
  final String uid;
  Translatable name;
  Translatable? bio;
  CloudImage? logo;
  double? averageRating;
  String? companyId;

// Marketing related fields
  final double? weight;
  final bool? isAd;

  List<City>? regains;

  List<AvailableService>? availableServices;
  BankInfo? bankInfo;
  bool? isHidden;
  ServiceType? type;
  ServiceStatus? status;
  List<Location>? coveringArea;
  ServiceProvider(
      {required this.uid,
      required this.name,
      this.bio,
      this.logo,
      this.averageRating,
      this.weight,
      this.regains,
      this.isAd,
      this.availableServices,
      this.bankInfo,
      this.isHidden,
      this.type,
      this.status,
      this.coveringArea,
      this.companyId});

  ServiceProvider copyWith(
      {String? uid,
      Translatable? name,
      Translatable? bio,
      CloudImage? logo,
      double? averageRating,
      double? weight,
      bool? isAd,
      List<AvailableService>? availableServices,
      BankInfo? bankInfo,
      bool? isHidden,
      List<City>? regains,
      ServiceType? type,
      ServiceStatus? status,
      List<Location>? coveringArea,
      String? companyId}) {
    return ServiceProvider(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        logo: logo ?? this.logo,
        regains: regains ?? this.regains,
        averageRating: averageRating ?? this.averageRating,
        weight: weight ?? this.weight,
        isAd: isAd ?? this.isAd,
        availableServices: availableServices ?? this.availableServices,
        bankInfo: bankInfo ?? this.bankInfo,
        isHidden: isHidden ?? this.isHidden,
        type: type ?? this.type,
        status: status ?? this.status,
        coveringArea: coveringArea ?? this.coveringArea,
        companyId: companyId ?? this.companyId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name.toMap(),
      'bio': bio?.toMap(),
      'logo': logo?.toMap(),
      'averageRating': averageRating,
      'weight': weight,
      'isAd': isAd,
      'availableServices': availableServices != null ? toListOfMap(availableServices!) : null,
      'bankInfo': bankInfo?.toMap(),
      'isHidden': isHidden,
      'type': enumToString(type),
      'status': enumToString(status),
      'regains': regains != null ? toListOfMap(regains!) : null,
      'companyId': companyId,
    };
  }

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
        uid: map['uid'] as String,
        name: Translatable.fromMap(map['name'] as Map<String, dynamic>),
        bio: map['bio'] != null ? Translatable.fromMap(map['bio'] as Map<String, dynamic>) : null,
        logo: map['logo'] != null ? CloudImage.fromMap(map['logo'] as Map<String, dynamic>) : null,
        averageRating: map['averageRating'] != null ? map['averageRating'] as double : null,
        weight: map['weight'] != null ? map['weight'] as double : null,
        isAd: map['isAd'] != null ? map['isAd'] as bool : null,
        availableServices:
            map['availableServices'] != null ? fromListOfMap(AvailableService.fromMap, map['availableServices']) : null,
        bankInfo: map['bankInfo'] != null ? BankInfo.fromMap(map['bankInfo'] as Map<String, dynamic>) : null,
        isHidden: map['isHidden'] != null ? map['isHidden'] as bool : null,
        type: map['type'] != null ? enumFromString(ServiceType.values, map['type']) : null,
        status: map['status'] != null ? enumFromString(ServiceStatus.values, map['status']) : null,
        regains: map['regains'] != null ? fromListOfMap(City.fromMap, map['regains']) : null,
        coveringArea: map['coveringArea'] != null ? fromListOfMap(Location.fromMap, map['coveringArea']) : null,
        companyId: map['companyId'] != null ? map['companyId'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory ServiceProvider.fromJson(String source) =>
      ServiceProvider.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceProvider(uid: $uid, name: $name, bio: $bio, logo: $logo, averageRating: $averageRating, weight: $weight, isAd: $isAd, availableServices: $availableServices, bankInfo: $bankInfo, isHidden: $isHidden, type: $type, status: $status, coveringArea: $coveringArea), companyId: $companyId';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ServiceProvider &&
        other.uid == uid &&
        other.name == name &&
        other.bio == bio &&
        other.logo == logo &&
        other.averageRating == averageRating &&
        other.weight == weight &&
        other.isAd == isAd &&
        listEquals(other.availableServices, availableServices) &&
        other.bankInfo == bankInfo &&
        other.isHidden == isHidden &&
        other.type == type &&
        other.status == status &&
        other.coveringArea == coveringArea &&
        other.companyId == companyId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        logo.hashCode ^
        averageRating.hashCode ^
        weight.hashCode ^
        isAd.hashCode ^
        availableServices.hashCode ^
        bankInfo.hashCode ^
        isHidden.hashCode ^
        type.hashCode ^
        status.hashCode ^
        coveringArea.hashCode ^
        companyId.hashCode;
  }

//FIXME: make these check for all feildes
  bool get isNotCompleted => bankInfo == null || bio == null;
}
