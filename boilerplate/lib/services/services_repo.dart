import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/models/available_service.dart';
import 'package:garage_client/models/serivce_provider.dart';
import 'package:garage_client/models/service.dart';
import 'package:garage_client/models/translatable.dart';
import 'package:garage_client/services/firestore_repo.dart';
import 'package:garage_client/utils/logger/g_logger.dart';

final servicesRepoProvider = Provider<ServicesRepo>(
  (ref) => ServicesRepo(firestoreRepo: ref.watch(firestoreRepoProvider)),
);

final serviceByIdProvider = FutureProvider.family<Service?, String>((ref, serviceId) async {
  return await ref.read(servicesRepoProvider).getServiceFromId(serviceId);
});

final serviceRootParentProvider = FutureProvider.family<Service?, String>((ref, serviceId) async {
  return await ref.read(servicesRepoProvider).getRootServiceFromServiceId(serviceId);
});

final rootSubServicesProvider = FutureProvider.family<List<Service>?, String>((ref, serviceId) async {
  return await ref.read(servicesRepoProvider).getMainServicesGroups(serviceId);
});

class ServicesRepo {
  ServicesRepo({required this.firestoreRepo});
  final FirestoreRepo firestoreRepo;

  Future<Translatable?> getServiceName(String serviceId) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection.doc(serviceId).get()).data();

      if (serviceData != null) {
        final service = Service.fromMap(serviceData);
        return service.name;
      } else {
        return null;
      }
    } catch (e) {
      e.logException();
      return null;
    }
  }

  Future<Service?> getServiceFromId(String id) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection.doc(id).get()).data();

      if (serviceData != null) {
        final service = Service.fromMap(serviceData);
        return service;
      } else {
        return null;
      }
    } catch (e) {
      e.logException();
      return null;
    }
  }

  Future<Service?> getRootServiceFromServiceId(String serviceId) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection.where("id", isEqualTo: serviceId).get());

      if (serviceData.docs.isNotEmpty) {
        Service? service = serviceData.docs.map((service) => Service.fromMap(service.data())).first;

        Service? parentService;
        bool reachedRoot = false;
        // loop until you reach the parent root of your service
        do {
          final parentServiceData =
              (await firestoreRepo.servicesCollection.where("id", isEqualTo: service?.parent ?? "").get());

          if (parentServiceData.docs.isNotEmpty) {
            parentService = parentServiceData.docs.map((service) => Service.fromMap(service.data())).first;

            if (parentService.parent == null) {
              reachedRoot = true;
            } else {
              service = parentService;
            }
          }
        } while (!reachedRoot);
        return parentService;
      }
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<List<Service>?> getMainServicesGroups(String serviceId) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection.where("parent", isEqualTo: serviceId).get());

      if (serviceData.docs.isNotEmpty) {
        List<Translatable> servicesNames = [];
        List<Service> servicesList = [];

        for (var serviceData in serviceData.docs) {
          final service = Service.fromMap(serviceData.data());

          if (!servicesNames.contains(service.name)) {
            servicesNames.add(service.name);
            servicesList.add(service);
          }
        }
        return servicesList;
      } else {
        return null;
      }
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<Service?> getServiceByCarTypeAndServiceName(Translatable serviceName, CarType carType) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection
          .where("name", isEqualTo: serviceName.toMap())
          .where("carTypes", arrayContains: carType.name)
          .get());

      if (serviceData.docs.isNotEmpty) {
        Service service = serviceData.docs.map((service) => Service.fromMap(service.data())).first;
        return service;
      } else {
        return null;
      }
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<List<Service>?> getOtherServicesByParentIdAndCarType(String serviceId, CarType carType) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection
          .where("parent", isEqualTo: serviceId)
          .where("carTypes", arrayContains: carType.name)
          .get());
      if (serviceData.docs.isNotEmpty) {
        final otherServicesList = serviceData.docs.map((service) => Service.fromMap(service.data())).toList();
        return otherServicesList;
      } else {
        return null;
      }
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<Service?> getParent(String id) async {
    try {
      final serviceData = (await firestoreRepo.servicesCollection.doc(id).get()).data();
      if (serviceData != null) {
        final service = Service.fromMap(serviceData);
        final parent = getServiceFromId(service.parent ?? '');
        return parent;
      } else {
        return null;
      }
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<List<ServiceProvider>> getServiceProvidersForService(String serviceId) async {
    try {
      final List<ServiceProvider> serviceProvidersList = [];
      final serviceProvidersSnapshot = await firestoreRepo.serviceProvidersCollection.get();

      for (final doc in serviceProvidersSnapshot.docs) {
        if (doc.exists) {
          try {
            serviceProvidersList.add(ServiceProvider.fromMap(doc.data()));
          } catch (e) {
            e.logException();
          }
        }
      }

      final filteredList = serviceProvidersList
          .where((serviceProvider) =>
              serviceProvider.availableServices?.any((availableService) => availableService.id == serviceId) ?? false)
          .toList();

      return filteredList;
    } catch (e) {
      e.logException();
      return [];
    }
  }

  Future<AvailableService> getAvailableServiceForServiceProvider(String serviceId, String serviceProviderId) async {
    try {
      /// We need to get the service provider from the database and then get the price from its [availableServices]
      ///
      /// For testing I will query this list

      final serviceProviderDoc = await firestoreRepo.serviceProvidersCollection.doc(serviceProviderId).get();
      final data = serviceProviderDoc.data();
      if (data != null) {
        if (data.containsKey('availableServices')) {
          final availableService = data['availableServices'] as List<dynamic>;

          final serviceData = availableService.firstWhere(
            (serviceMap) => serviceMap['id'] == serviceId,
          );

          final service = AvailableService.fromMap(serviceData);
          return service;
        } else {
          GLogger.warning('the requested timeslot was not found');
          throw Exception('The requested service was not found');
        }
      } else {
        GLogger.warning('the requested service was not found');
        throw Exception('The requested service was not found');
      }
    } catch (e) {
      e.logException();
      GLogger.warning('the requested service was not found');
      throw Exception('The requested service was not found');
    }
  }

  Future<List<Service>> getRootServices() async {
    try {
      final data = await firestoreRepo.servicesCollection.get();
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
}
