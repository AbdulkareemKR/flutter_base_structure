import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/services/firestore_repo.dart';

final orderRepoProvider = Provider<OrderRepo>(((ref) => OrderRepo(firestoreRepo: ref.watch(firestoreRepoProvider))));

final streamedOrderProvider = StreamProvider.family<Order?, String?>((ref, orderId) {
  return ref.watch(orderRepoProvider).getStreamedOrder(orderId);
});

class OrderRepo {
  final FirestoreRepp  firestoreRepo;
  OrderRepo({
    required this.firestoreRepo,
  });

  Future<List<Order>> getOrdersForServiceProvider(String? serviceProviderId) async {
    if (serviceProviderId == null) {
      return [];
    } else {
      try {
        final orderDocs =
            (await firestoreRepo.ordersCollection.where("serviceProviderId", isEqualTo: serviceProviderId).get()).docs;
        if (orderDocs.isNotEmpty) {
          final ordersList = orderDocs.map<Order>((order) => Order.fromMap(order.data())).toList();
          return ordersList;
        } else {
          return [];
        }
      } catch (e) {
        log('$e');
        ;
        return [];
      }
    }
  }

  Future<List<Order>> getOrdersForTechnician(String? technicianId) async {
    if (technicianId == null) {
      return [];
    } else {
      try {
        final orderDocs =
            (await firestoreRepo.ordersCollection.where('technicianIds', arrayContains: technicianId).get()).docs;
        if (orderDocs.isNotEmpty) {
          final orders = orderDocs.map<Order>((orderDoc) => Order.fromMap(orderDoc.data()));
          return orders.toList();
        } else {
          log('No orders for this technician 🛑');
          return [];
        }
      } catch (e) {
        log('$e');
        ;
        return [];
      }
    }
  }

  Stream<List<Order>> getOrdersStreamForServiceProvider(String? serviceProviderId) {
    if (serviceProviderId == null) {
      return const Stream.empty();
    } else {
      try {
        final orderDocs = firestoreRepo.ordersCollection
            .where("serviceProviderId", isEqualTo: serviceProviderId)
            .where('status', isNotEqualTo: 'canceled')
            .snapshots()
            .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
        return orderDocs;
      } catch (e) {
        log('$e');
        return const Stream.empty();
      }
    }
  }

  Stream<List<Order>> getPaidOrdersStreamForServiceProvider(String? serviceProviderId) {
    if (serviceProviderId == null) {
      return const Stream.empty();
    } else {
      try {
        final orderDocs = firestoreRepo.ordersCollection
            .where("serviceProviderId", isEqualTo: serviceProviderId)
            .where('transaction.paymentStatus', isEqualTo: "paid")
            .snapshots()
            .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
        return orderDocs;
      } catch (e) {
        log('$e');
        return const Stream.empty();
      }
    }
  }

  Stream<List<Order>> getUnCompletedOrderStream(String? serviceProviderId) {
    if (serviceProviderId == null) {
      return const Stream.empty();
    } else {
      try {
        final orderDocs = firestoreRepo.ordersCollection
            .where("serviceProviderId", isEqualTo: serviceProviderId)
            .where('transaction.paymentStatus', isEqualTo: "paid")
            .where('status', isNotEqualTo: 'completed')
            .snapshots()
            .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
        return orderDocs;
      } catch (e) {
        log('$e');
        return const Stream.empty();
      }
    }
  }

  Future<List<Order>> getCompletedOrders(String? serviceProviderId) async {
    if (serviceProviderId == null) {
      return [];
    } else {
      try {
        final orderDocs = (await firestoreRepo.ordersCollection
                .where("serviceProviderId", isEqualTo: serviceProviderId)
                .where('status', isEqualTo: OrderStatus.completed.name)
                .get())
            .docs
            .map((doc) => Order.fromMap(doc.data()))
            .toList();
        return orderDocs;
      } catch (e) {
        log('$e');
        return [];
      }
    }
  }

  Future<bool> acceptOrder(Order order) async {
    try {
      await firestoreRepo.ordersCollection.doc(order.id).update({'status': OrderStatus.accepted.name});
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> cancelOrder(Order order) async {
    return await changeOrderStatus(order.id, OrderStatus.cancelled);
  }

  Stream<Order?> getActiveOrderStream(String uid) {
    try {
      final snapshot = firestoreRepo.ordersCollection
          .where("uid", isEqualTo: uid)
          .where("status", isNotEqualTo: "completed")
          .where("isPaid", isEqualTo: true)
          .snapshots()
          .map((list) {
        final ordersList = list.docs.map((doc) => Order.fromMap(doc.data())).toList();
        // remove inactive orders
        final filteredOrders = ordersList.where((order) => order.isActiveOrder);
        if (filteredOrders.isNotEmpty) {
          // find the newest order
          Order latestOrder = filteredOrders.first;
          for (final order in filteredOrders) {
            if (latestOrder.orderDates!.orderDate.compareTo(order.orderDates!.orderDate) < 0) {
              latestOrder = order;
            }
          }
          return latestOrder;
        }
      });
      return snapshot;
    } catch (e) {
      log('$e');
      ;
      return const Stream.empty();
    }
  }

  Stream<List<Order>> getOrdersStream(String userId) {
    try {
      final ordersStream = firestoreRepo.ordersCollection
          .where('uid', isEqualTo: userId)
          .snapshots()
          .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
      return ordersStream;
    } catch (e) {
      log('$e');
      ;
      return const Stream.empty();
    }
  }

  Stream<Order> getStreamedOrder(String? orderId) {
    if (orderId == null) {
      return const Stream.empty();
    }
    try {
      final streamedOrder =
          firestoreRepo.ordersCollection.doc(orderId).snapshots().map((order) => Order.fromMap(order.data()!));
      return streamedOrder;
    } catch (e) {
      log('$e');
      ;
      return const Stream.empty();
    }
  }

  void postOrderRating({required String orderId, required OrderRate orderRate}) {
    firestoreRepo.ordersCollection.doc(orderId).update({
      "rating": FieldValue.arrayUnion([orderRate.toMap()]),
    }).then((value) => log("rating added successfully!"), onError: (e) => log("Error adding rating $e"));
  }

  void hideOrder(String orderId) {
    firestoreRepo.ordersCollection.doc(orderId).update(
      {'isVisible': false},
    ).then((value) => log("order has been hided"), onError: (e) => log("Error hiding order $e"));
  }

  Stream<List<Order>> getTechnicianOrdersStream(String? technicianId) {
    if (technicianId == null) {
      return const Stream.empty();
    } else {
      try {
        final ordersStream = firestoreRepo.ordersCollection
            .where('technicianIds', arrayContains: technicianId)
            .snapshots()
            .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
        return ordersStream;
      } catch (e) {
        log('$e');
        ;
        return const Stream.empty();
      }
    }
  }

  Future<bool> changeOrderStatus(String? orderId, OrderStatus newStatus) async {
    if (orderId == null) {
      return Future.value(false);
    }
    try {
      await firestoreRepo.ordersCollection.doc(orderId).update({'status': newStatus.name});
      return Future.value(true);
    } catch (e) {
      log('$e');
      return Future.value(false);
    }
  }
}
