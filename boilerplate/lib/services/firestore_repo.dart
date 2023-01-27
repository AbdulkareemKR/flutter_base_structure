import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreRepoProvider = Provider<FirestoreRepo>(
  (ref) => FirestoreRepo(),
);

class FirestoreRepo {
  final techniciansCollection = FirebaseFirestore.instance.collection('Technician');
  final servicesCollection = FirebaseFirestore.instance.collection('Service');
  final carOwnersCollection = FirebaseFirestore.instance.collection('CarOwner');
  final carsCollection = FirebaseFirestore.instance.collection('Car');
  final colorsCollection = FirebaseFirestore.instance.collection('CarColor');
  final timeslotsCollection = FirebaseFirestore.instance.collection('Timeslot');
  final timeslotRepeatsCollection = FirebaseFirestore.instance.collection('TimeslotRepeat');
  final banksCollection = FirebaseFirestore.instance.collection('Banks');
  final citiesCollection = FirebaseFirestore.instance.collection('City');
  final neighborhoodsCollection = FirebaseFirestore.instance.collection('Neighborhoods');
  final ordersCollection = FirebaseFirestore.instance.collection('Order');
  final serviceProvidersCollection = FirebaseFirestore.instance.collection('ServiceProvider');
  final userCarCollection = FirebaseFirestore.instance.collection('UserCar');
  final couponsCollection = FirebaseFirestore.instance.collection('Coupon');
  final walletsCollection = FirebaseFirestore.instance.collection('Wallet');
  final technicianLiveLocationsCollection = FirebaseFirestore.instance.collection('TechnicianLiveLocations');
  final firestore = FirebaseFirestore.instance;
  //TODO: implement the needed methods
}
