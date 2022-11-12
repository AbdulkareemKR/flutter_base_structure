import 'package:garage_core/models/order.dart';
import 'package:garage_core/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';

@Deprecated('Use OrderRepo')
Stream<List<Order>> getOrdersStream(String userId) {
  try {
    final ordersStream = FirestoreServices.ordersCollection
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map((list) => list.docs.map((doc) => Order.fromMap(doc.data())).toList());
    return ordersStream;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}

Stream<Order?> getActiveOrderStream(String uid) {
  try {
    final snapshot = FirestoreServices.ordersCollection
        .where("uid", isEqualTo: uid)
        .where("status", isNotEqualTo: "cancel")
        .where("isPaid", isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((list) {
      final ordersList = list.docs.map((doc) => Order.fromMap(doc.data())).toList();
      if (ordersList.isNotEmpty) {
        return ordersList.first;
      }
    });
    return snapshot;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}

void postOrderRating(String orderId, OrderRate orderRate) {
  FirestoreServices.ordersCollection.doc(orderId).update({
    "rating": FieldValue.arrayUnion([orderRate.toMap()]),
  }).then((value) => GLogger.debug("rating added successfully!"),
      onError: (e) => GLogger.error("Error adding rating $e"));
}

void hideOrder(String orderId) {
  FirestoreServices.ordersCollection.doc(orderId).update(
    {'isVisible': false},
  ).then((value) => GLogger.debug("order has been hided"), onError: (e) => GLogger.error("Error hiding order $e"));
}
