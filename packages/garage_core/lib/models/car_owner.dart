import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:garage_core/models/user_location.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/services/list_services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

class CarOwner extends ChangeNotifier {
  // User id
  final String uid;

  // User's basic information
  String name;
  String? email;
  String? phoneNumber;
  UserCar? defaultCar;

  // User location related fields
  List<UserLocation> locations;
  UserLocation? defaultLocation;

  CarOwner({
    required this.uid,
    required this.name,
    this.email,
    this.phoneNumber,
    List<UserLocation>? locations,
    this.defaultLocation,
    this.defaultCar,
  }) : locations = locations ?? [];

  /// Add a [UserLocation] to the user's locations if it is the first location added it will be the default
  void addLocation(UserLocation location) {
    if (!locations.contains(location)) {
      locations.add(location);
      if (locations.length == 1) {
        // If it is the first location added
        defaultLocation = location;
      }
      GLogger.debug('Location has been added successfully');
    } else {
      GLogger.warning('Location already exists');
    }
    notifyListeners();
  }

  CarOwner copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    List<UserLocation>? locations,
    UserLocation? defaultLocation,
  }) {
    return CarOwner(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      locations: locations ?? this.locations,
      defaultLocation: defaultLocation ?? this.defaultLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'locations': toListOfMap(locations),
      'defaultLocation': defaultLocation?.toMap(),
      'defaultCar': defaultCar?.toMap(),
    };
  }

  factory CarOwner.fromMap(Map<String, dynamic> map) {
    return CarOwner(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      locations: fromListOfMap(UserLocation.fromMap, map['locations']),
      defaultLocation: map['defaultLocation'] != null ? UserLocation.fromMap(map['defaultLocation']) : null,
      defaultCar: map['defaultCar'] != null ? UserCar.fromMap(map['defaultCar']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarOwner.fromJson(String source) => CarOwner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarOwner(uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, locations: $locations, defaultLocation: $defaultLocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CarOwner &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.locations, locations) &&
        other.defaultLocation == defaultLocation;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        locations.hashCode ^
        defaultLocation.hashCode;
  }

  void changeDefaultLocation(UserLocation location) {
    if (!locations.contains(location)) {
      GLogger.warning('The location $location was not in the user\'s locations, but it is added');
      locations.add(location);
    }
    defaultLocation = location;
    notifyListeners();
  }

  void deleteLocation(UserLocation location) {
    if (locations.contains(location)) {
      locations.remove(location);
      if (location == defaultLocation) {
        // If the user deleted his default location we need to replace it

        if (locations.isNotEmpty) {
          changeDefaultLocation(locations.first);
        } else {
          defaultLocation = null;
          // The user has deleted all locations
        }
      }

      notifyListeners();
    } else {
      GLogger.warning('The location is not in the user\'s locations');
    }
  }
}
