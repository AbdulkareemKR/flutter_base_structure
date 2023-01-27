import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/models/car_owner.dart';
import 'package:garage_client/services/firestore_services.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

Future<CarOwner?> getCarOwnerFromId(String uid) async {
  final user = await FirebaseFirestore.instance.collection('CarOwner').where('uid', isEqualTo: uid).get();
  if (user.docs.isNotEmpty) {
    final carOwner = CarOwner.fromMap(user.docs.first.data());
    return carOwner;
  } else {
    return null;
  }
}

Future<CarOwner?> createCarOwner(String uid, String name, String phoneNumber) async {
  final CarOwner carOwner = CarOwner(uid: uid, name: name, locations: [], phoneNumber: phoneNumber);
  try {
    await FirestoreServices.carOwnersCollection.doc(uid).set(carOwner.toMap());
    return carOwner;
  } catch (e) {
    e.logException();
    return null;
  }
}

String? getNameFromPhoneNumber(String phoneNumber) {
  /// TODO : write a query to get the [CarOwner] doc that:
  /// where( phoneNumber == phoneNumber )
  /// then if the doc exists return its name
  /// if NOT return null (which means that the user is not registered in our app)
  ///
  /// For testing i will user this local data
  final usersNumbers = {
    '0533835211': 'نواف العمري',
    '0551088910': 'صلاح',
    '0507123433': "هادي الحنفوش",
    '0512345678': 'مستخدم جديد'
  };
  return usersNumbers[phoneNumber]; // This is not a  query, just for testing
}
