import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_core/models/car.dart';
import 'package:garage_core/models/color.dart';
import 'package:garage_core/models/service.dart';
import 'package:garage_core/models/translatable.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/services/car_owner_services.dart';
import 'package:garage_core/services/firestore_services.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

String getCarName(String carId) {
  // TODO : get the car name from car constant model using carId

  // I'm returning this String for testing
  final dummyCars = {'car1': 'شانجان, ايدو', 'car2': 'تويوتا، كامري', 'car3': 'جمس، بوكن', 'car4': 'سيارة'};
  return dummyCars[carId] ?? '';
}

/// This function will return the (Starts with) price in [sar]
Future<double> getMinPriceForService(UserCar car, Service service) async {
  // TODO : implement the function to get the minimum price for a car type and class
  // Get all AvailableServices that has this service.id and the same car type and class
  // then get the minimum and return it.
  final carTypeClass = await getCarTypeAndClass(car.carId!);

  final servicePrice = await FirestoreServices.servicesCollection
      .where('parent', isEqualTo: service.id)
      .where('carTypes', arrayContains: carTypeClass['type'])
      .get();
  if (servicePrice.docs.isNotEmpty) {
    double minimum = double.infinity;
    for (final service in servicePrice.docs) {
      final data = service.data();
      final minPrice = data['priceRange']['min'];
      if (minPrice < minimum) {
        minimum = minPrice;
      }
    }

    return minimum;
  }

  // For testing I will return 20.0
  return 20.0;
}

Map<Translatable, List<Car>> groupCarsByCompany(List<Car> carsList) {
  //TODO : use local
  final Map<Translatable, List<Car>> carsMap = {};
  for (final car in carsList) {
    if (carsMap.containsKey(car.company)) {
      carsMap[car.company]!.add(car);
    } else {
      carsMap[car.company] = [car];
    }
  }
  return carsMap;
}

Future<Map<String, Translatable>> getCarCompanyBrand(String carId) async {
  try {
    final Map<String, Translatable> carCompanyBrand = {};
    final car = await getCarFromId(carId);
    if (car != null) {
      //TODO: use local
      carCompanyBrand['company'] = car.company;
      carCompanyBrand['brand'] = car.brand;
    }
    return carCompanyBrand;
  } catch (e) {
    e.logException();
    return {};
  }
}

Future<String> getCarCompany(String carId) async {
  try {
    final car = await getCarFromId(carId);
    if (car != null) {
      //TODO: use local
      return car.company.ar;
    } else {
      return '';
    }
  } catch (e) {
    e.logException();
    return '';
  }
}

String getCarBrand(String carId) {
  final dummyCars = {'car1': 'ايدو', 'car2': 'كامري', 'car3': 'يوكن', 'car4': 'سيارة'};
  return dummyCars[carId] ?? '';
}

Future<Car?> getCarFromId(String carId) async {
  try {
    final carData = (await FirestoreServices.carsCollection.doc(carId).get()).data();
    if (carData != null) {
      final car = Car.fromMap(carData);
      return car;
    }
  } catch (e) {
    GLogger.warning('The car dose not exist!');
    e.logException();
    return null;
  }
  return null;
}

Future<Map<String, String>> getCarTypeAndClass(String carId) async {
  final carDoc = await FirestoreServices.carsCollection.doc(carId).get();
  final carData = carDoc.data();
  if (carData != null) {
    final Map<String, String> typeClassMap = {};
    if (carData.containsKey('carClass')) {
      typeClassMap['class'] = carData['carClass'].toLowerCase();
    }
    if (carData.containsKey('type')) {
      typeClassMap['type'] = carData['type'].toLowerCase();
    }
    return typeClassMap;
  }
  return {};
}

/// This function will return the user's cars given the user id (uid)
Future<List<UserCar>> getUserCarsFromUid(String uid) async {
  try {
    /// Getting the cars for this [uid]
    final userCarsDocs = (await FirestoreServices.userCarCollection.where('uid', isEqualTo: uid).get()).docs;

    /// Check that the user has cars
    if (userCarsDocs.isNotEmpty) {
      /// Map the docs into [UserCar] objects
      final userCarsList = userCarsDocs.map((carDoc) {
        return UserCar.fromMap(carDoc.data());
      }).toList();

      return userCarsList;
    } else {
      /// If the user dose not have cars simply will return an empty list
      return [];
    }
  } catch (e) {
    /// in case of any errors log the error then return empty list
    e.logException();

    return [];
  }
}

/// This function will return the user's cars given the user id (uid)
Stream<List<UserCar>> getUserCarsStream(String uid) {
  try {
    /// Getting the cars for this [uid]
    final userCarsDocs = (FirestoreServices.userCarCollection.where('uid', isEqualTo: uid).snapshots())
        .map((cars) => cars.docs.map((car) => UserCar.fromMap(car.data())).toList());

    return userCarsDocs;
  } catch (e) {
    /// in case of any errors log the error then return empty list
    e.logException();

    return const Stream.empty();
  }
}

Future<List<Car>> getConstCars() async {
  try {
    final carsDocs = (await FirestoreServices.carsCollection.get()).docs;
    if (carsDocs.isNotEmpty) {
      final carsList = carsDocs.map((car) => Car.fromMap(car.data())).toList();
      return carsList;
    } else {
      return [];
    }
  } catch (e) {
    e.logException();
    return [];
  }
}

Future<List<CarColor>> getConstColors() async {
  try {
    final colorsDocs = (await FirestoreServices.colorsCollection.get()).docs;
    if (colorsDocs.isNotEmpty) {
      final colorsMap = colorsDocs.map((color) => CarColor.fromMap(color.data())).toList();
      return colorsMap;
    } else {
      return [];
    }
  } catch (e) {
    e.logException();
    return [];
  }
}

Future<bool> addNewCar(UserCar car) async {
  try {
    final docRef = FirestoreServices.userCarCollection.doc();

    final carMap = car.toMap();
    carMap['id'] = docRef.id;
    await docRef.set(carMap);

    /// Check if the user dose not have a default car (it is the first car added).
    final carOwner = await getCarOwnerFromId(car.uid);
    if (carOwner != null) {
      if (carOwner.defaultCar == null) {
        // It will be set as his/her default car.
        setDefaultCar(carMap, carOwner.uid);
      }
    }

    return true;
  } catch (e) {
    e.logException();
    return false;
  }
}

Future<bool> editCar(UserCar car) async {
  try {
    /// Edit the car on [Firestore]
    await FirestoreServices.userCarCollection.doc(car.id).set(car.toMap());

    final carOwner = await getCarOwnerFromId(car.uid);
    if (carOwner != null) {
      if (carOwner.defaultCar?.id == car.id) {
        /// If the user edit his default car
        await setDefaultCar(car.toMap(), carOwner.uid);
      }
    }
    return true;
  } catch (e) {
    e.logException();
    return false;
  }
}

Future<bool> deleteCar(String carId) async {
  try {
    /// Getting the car info that will be deleted
    final carToDeleteData = (await FirestoreServices.userCarCollection.doc(carId).get()).data();
    if (carToDeleteData != null) {
      //If the car exist, the car will be deleted
      await FirestoreServices.userCarCollection.doc(carId).delete();

      /// We need to check whither or not the car is the user's default car
      final carToDelete = UserCar.fromMap(carToDeleteData);
      final carOwner = await getCarOwnerFromId(carToDelete.uid);
      if (carOwner != null) {
        // Check if the car deleted is the default car
        if (carToDelete == carOwner.defaultCar) {
          /// If so we will get all the user's other car and assign him/her a new one
          final userCars = await getUserCarsFromUid(carOwner.uid);
          if (userCars.isNotEmpty) {
            setDefaultCar(userCars.first.toMap(), carOwner.uid);
          } else {
            /// In case the user deleted his last car the method will be called with null
            /// which will delete the defaultCar field from teh user.
            setDefaultCar(null, carOwner.uid);
          }
        }
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    e.logException();
    return false;
  }
}

Future<bool> setDefaultCar(Map<String, dynamic>? carMap, String uid) async {
  try {
    FirestoreServices.carOwnersCollection.doc(uid).update({'defaultCar': carMap ?? FieldValue.delete()});
    GLogger.debug('Default car has been changed for user with uid $uid');
    return true;
  } catch (e) {
    e.logException();
    return false;
  }
}
