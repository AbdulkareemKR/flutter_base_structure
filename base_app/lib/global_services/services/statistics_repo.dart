import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/cities_repo.dart';
import 'package:garage_client/global_services/services/service_providers_repo.dart';
import 'package:garage_client/global_services/services/services_repo.dart';
import 'package:intl/intl.dart';

final statisticRepoProvider = Provider<StatisticsRepo>((ref) {
  return StatisticsRepo(citiesRepo: ref.watch(citiesRepoProvider), servicesRepo: ref.watch(servicesRepoProvider));
});

class StatisticsRepo {
  final CitiesRepo citiesRepo;
  final ServicesRepo servicesRepo;

  StatisticsRepo({required this.citiesRepo, required this.servicesRepo});

  Map<String, double> filterByMonth(List<Order> orders) {
    final Map<String, double> ordersPerMonth = {
      'Jan': 0,
      'Feb': 0,
      'Mar': 0,
      'Apr': 0,
      'May': 0,
      'Jun': 0,
      'Jul': 0,
      'Aug': 0,
      'Sep': 0,
      'Oct': 0,
      'Nov': 0,
      'Dec': 0
    };

    orders.forEach((order) {
      final month = DateFormat.MMM().format(order.timeslot.dateFrom.toDate());
      ordersPerMonth[month] = (ordersPerMonth[month] ?? 0) + 1;
    });

    return ordersPerMonth;
  }

  Future<Map<String, double>> statisticByCity(List<Order> orders, String localCode) async {
    final Map<String, double> orderPerCity = {};

    await Future.forEach<Order>(orders, (order) async {
      final city = (await citiesRepo.getCityName(order.location.cityId));
      final key = localCode == 'ar' ? city.ar : city.en;
      orderPerCity[key] = (orderPerCity[key] ?? 0) + 1;
    });

    return orderPerCity;
  }

  Future<Map<String, double>> statisticByService(List<Order> orders, String localCode) async {
    final Map<String, double> orderPerService = {};
    int sum = 0;
    await Future.forEach<Order>(orders, (order) async {
      final root = (await servicesRepo.getParent(order.selectedServices.first.id))?.name;
      final key = (localCode == 'ar' ? root?.ar : root?.en) ?? '';
      sum++;

      orderPerService[key] = (orderPerService[key] ?? 0) + 1;
    });

    final Map<String, double> percentMap = {};

    orderPerService.forEach((key, value) {
      percentMap[key] = sum != 0 ? ((value / sum) * 100) : 0;
    });

    return orderPerService;
  }

  Future<Map<String, double>> getAvgDoneTime(List<Order> orders, String localCode) async {
    final Map<String, List<Order>> orderPerCity = {};

    await Future.forEach<Order>(orders, (order) async {
      final city = (await citiesRepo.getCityName(order.location.cityId));
      final key = localCode == 'ar' ? city.ar : city.en;
      if (orderPerCity.containsKey(key)) {
        orderPerCity[key]!.add(order);
      } else {
        orderPerCity[key] = [order];
      }
    });

    final Map<String, double> avgTimeMap = {};
    orderPerCity.forEach((key, orders) {
      int totalTime = 0;
      orders.forEach((singleOrder) {
        totalTime += singleOrder.orderDates!.checkoutDate!.difference(singleOrder.orderDates!.orderDate).inMinutes;
      });

      avgTimeMap[key] = orders.isNotEmpty ? totalTime / orders.length : 0;
    });

    return avgTimeMap;
  }
}
