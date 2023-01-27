import 'package:garage_client/models/serivce_provider.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/transaction.dart';
import 'package:garage_client/models/transaction_constant.dart';
import 'package:garage_client/services/car_services.dart';
import 'package:garage_client/services/firestore_services.dart';
import 'package:garage_client/utils/logger/g_logger.dart';
import 'package:collection/collection.dart';

Future<List<Service>> getRootServices() async {
  try {
    final data = await FirestoreServices.servicesCollection.get();
    if (data.docs.isNotEmpty) {
      final roots = data.docs.where((element) => !(element.data().containsKey('parent')));
      final servicesList = roots.map((e) {
        return Service.fromMap(e.data());
      }).toList();

      return servicesList;
    } else {
      GLogger.warning('no services');
      return [];
    }
  } catch (e) {
    e.logException();
    return [];
  }
}

Future<Transaction> getTransaction({required String id}) async {
  try {
    return Transaction.fromMap((await FirestoreServices.transactionCollection.doc(id).get()).data()!);
  } catch (e) {
    e.logException();
    throw Exception("Couldn't get transaction with id $id");
  }
}

Future<List<Service>> getServicesFromParent(String parentId, String carId) async {
  try {
    final carTypeClass = await getCarTypeAndClass(carId);
    final subServices = await FirestoreServices.servicesCollection
        .where('parent', isEqualTo: parentId)
        .where('carTypes', arrayContains: carTypeClass['type'])
        .get();

    if (subServices.docs.isNotEmpty) {
      try {
        // final filteredByClassList =
        //     subServices.docs.where((service) => (service.data()['carClasses'] as List).contains(carTypeClass['class']));
        final subServicesList = subServices.docs.map((service) {
          return Service.fromMap(service.data());
        });

        return subServicesList.toList();
      } catch (e) {
        e.logException();
      }
    }
  } catch (e) {
    e.logException();
  }

  return [];
}

/// This function will get you the price of the service for the service provider
/// for carType.
///
/// @prams serviceId: the id of the service, carId: the id of the car, carType: the type of the car
///
/// @return the price of the service for the service provider for carType.
Future<num> getServicePriceForServiceProvider(String serviceId, String serviceProviderId, String? carId) async {
  try {
    if (carId != null) {
      final car = await getCarFromId(carId);

      final serviceProviderDoc = await FirestoreServices.serviceProvidersCollection.doc(serviceProviderId).get();
      final data = serviceProviderDoc.data();
      if (data != null) {
        final serviceProvider = ServiceProvider.fromMap(data);
        if (serviceProvider.availableServices != null) {
          final service = serviceProvider.availableServices!.firstWhereOrNull(
            (serviceElement) => serviceElement.id == serviceId && serviceElement.carTypes!.contains(car!.type),
          );

          final vatAmount = await FirestoreServices.transactionConstantsCollection.get();
          final vatData = vatAmount.docs.first.data();
          final transactionConstant = TransactionConstant.fromMap(vatData);
          return service == null ? 0.0 : transactionConstant.getPriceWithVat(service.price);
        } else {
          GLogger.warning('the requested timeslot was not found');
          return 0.0;
        }
      } else {
        GLogger.warning('the requested service was not found');
        return 0.0;
      }
    } else {
      throw Exception("The carId should not be null!");
    }
  } catch (e) {
    e.logException();
    GLogger.warning('the requested service was not found');
    return 0.0;
  }
}
