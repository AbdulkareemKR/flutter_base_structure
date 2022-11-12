import 'package:cloud_firestore/cloud_firestore.dart';

@Deprecated('This class is Deprecated, we now use [FirestoreRepo] update the current code please.')
class FirestoreServices {
  static final servicesCollection = firestore.collection('Service');
  static final carOwnersCollection = firestore.collection('CarOwner');
  static final carsCollection = firestore.collection('Car');
  static final colorsCollection = firestore.collection('CarColor');
  static final timeslotsCollection = firestore.collection('Timeslot');
  static final ordersCollection = firestore.collection('Order');
  static final serviceProvidersCollection = firestore.collection('ServiceProvider');
  static final userCarCollection = firestore.collection('UserCar');
  static final couponsCollection = firestore.collection('Coupon');
  static final walletsCollection = firestore.collection('Wallet');
  static final timeslotRepeatCollection = firestore.collection('TimeslotRepeat');
  static final techLiveLocationCollection = firestore.collection("TechnicianLiveLocation");
  static final transactionConstantsCollection = firestore.collection("TransactionConstant");
  static final transactionCollection = firestore.collection("Transaction");

  static final firestore = FirebaseFirestore.instance;

  //TODO: implement the needed methods
}
