import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:garage_core/enums/order_status.dart';
import 'package:garage_core/models/coupon.dart';
import 'package:garage_core/models/user_location.dart';
import 'package:garage_core/models/order_coupon.dart';
import 'package:garage_core/models/order_dates.dart';
import 'package:garage_core/models/order_rate.dart';
import 'package:garage_core/models/service.dart';
import 'package:garage_core/models/timeslot.dart';
import 'package:garage_core/models/transaction.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/services/enum_services.dart';

export 'package:garage_core/enums/order_status.dart';
export 'package:garage_core/models/user_location.dart';
export 'package:garage_core/models/order_coupon.dart';
export 'package:garage_core/models/order_dates.dart';
export 'package:garage_core/models/order_rate.dart';
export 'package:garage_core/models/tech_live_location.dart';

class Order {
  String? id;
  String uid;
  String serviceProviderId;
  String note;
  UserCar car;
  UserLocation location;
  List<String>? technicianIds;
  List<OrderRate>? rating;
  OrderStatus status;
  Transaction? transaction;
  List<Service> selectedServices;
  String? rejectionReason;
  bool isPaid;
  OrderCoupon? orderCoupon;
  Coupon? coupon;
  OrderDates? orderDates;
  bool useWallet;
  Timeslot timeslot;
  List<Service?>? otherServices;
  bool? isVisible;
  String? transactionId;
  Order({
    required this.id,
    required this.uid,
    required this.serviceProviderId,
    required this.car,
    required this.location,
    this.technicianIds,
    required this.note,
    this.rating,
    this.transaction,
    required this.status,
    required this.selectedServices,
    this.rejectionReason,
    required this.isPaid,
    this.coupon,
    required this.useWallet,
    this.orderDates,
    required this.timeslot,
    required this.otherServices,
    this.isVisible,
    this.transactionId,
  });

  bool get isActiveOrder {
    return status == OrderStatus.underProcessing ||
        status == OrderStatus.accepted ||
        status == OrderStatus.inTheWay ||
        status == OrderStatus.beingHandled;
  }

  Order copyWith({
    String? id,
    String? uid,
    String? serviceProviderId,
    UserCar? car,
    String? note,
    UserLocation? location,
    List<String>? technicianIds,
    List<OrderRate>? rating,
    Transaction? transaction,
    List<Service>? selectedService,
    String? rejectionReason,
    bool? isPaid,
    Coupon? coupon,
    bool? useWallet,
    Timeslot? timeslot,
    List<Service>? otherServices,
    OrderStatus? status,
    bool? isVisible,
    String? transactionId,
  }) {
    return Order(
      status: status ?? this.status,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      car: car ?? this.car,
      location: location ?? this.location,
      technicianIds: technicianIds ?? this.technicianIds,
      rating: rating ?? this.rating,
      transaction: transaction ?? this.transaction,
      selectedServices: selectedService ?? selectedServices,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isPaid: isPaid ?? this.isPaid,
      coupon: coupon ?? this.coupon,
      useWallet: useWallet ?? this.useWallet,
      timeslot: timeslot ?? this.timeslot,
      otherServices: otherServices ?? this.otherServices,
      note: note ?? this.note,
      isVisible: isVisible ?? this.isVisible,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'status': enumToString(status),
      'serviceProviderId': serviceProviderId,
      'note': note,
      'car': car.toMap(),
      'location': location.toMap(),
      'technicianIds': technicianIds,
      'rating': rating?.map((x) => x.toMap()).toList(),
      'transaction': transaction?.toMap(),
      'selectedService': selectedServices.map((x) => x.toMap()).toList(),
      'rejectionReason': rejectionReason,
      'isPaid': isPaid,
      'coupon': coupon?.toMap(),
      'useWallet': useWallet,
      'timeslot': timeslot.toMap(),
      'otherServices': otherServices != null ? otherServices!.map((x) => x?.toMap()).toList() : [],
      "isVisible": isVisible,
      "orderDates": orderDates?.toMap(),
      'transactionId': transactionId,
    };
  }

  /// This spacial function will give you [toMap] but with the [Timestamp] as map
  /// so you cna use it to call backend functions
  Map<String, dynamic> toCallableRequest() {
    final requestBody = toMap();
    requestBody['timeslot'] = timeslot.toCallableRequest();

    return requestBody;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    try {
      return Order(
          status: enumFromString(OrderStatus.values, map['status']),
          id: map['id'] != null ? map['id'] as String : null,
          uid: map['uid'] as String,
          note: map['note'] != null ? map['note'] as String : '',
          serviceProviderId: map['serviceProviderId'] as String,
          car: UserCar.fromMap(map['car'] as Map<String, dynamic>),
          location: UserLocation.fromMap(map['location'] as Map<String, dynamic>),
          technicianIds: map['technicianIds'] != null ? List<String>.from((map['technicianIds'])) : null,
          rating: map['rating'] != null
              ? List<OrderRate>.from(
                  (map['rating'] as List<dynamic>).map<OrderRate?>(
                    (x) => OrderRate.fromMap(x as Map<String, dynamic>),
                  ),
                )
              : null,
          transaction: map['transaction'] != null ? Transaction.fromMap(map['transaction']) : null,
          selectedServices: List.from((map['selectedService'])).map((service) => Service.fromMap(service)).toList(),
          rejectionReason: map['rejectionReason'] != null ? map['rejectionReason'] as String : null,
          isPaid: map['isPaid'] as bool,
          coupon: map['coupon'] != null ? Coupon.fromMap(map['coupon'] as Map<String, dynamic>) : null,
          useWallet: map['useWallet'] as bool,
          timeslot: Timeslot.fromMap(map['timeslot'] as Map<String, dynamic>),
          orderDates: map['orderDates'] != null ? OrderDates.fromMap(map['orderDates']) : null,
          otherServices: map['otherServices'] != null
              ? List.from((map['otherServices'])).map((service) => Service.fromMap(service)).toList()
              : null,
          isVisible: map['isVisible'] != null ? map['isVisible'] as bool : null,
          transactionId: map['transactionId'] != null ? map['transactionId'] as String : null);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, uid: $uid, serviceProviderId: $serviceProviderId, car: $car, location: $location, technicianIds: $technicianIds, rating: $rating, transaction: $transaction, selectedService: $selectedServices, rejectionReason: $rejectionReason, isPaid: $isPaid, coupon: $coupon, useWallet: $useWallet, timeslot: $timeslot, otherServices: $otherServices, isVisible $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Order &&
        other.id == id &&
        other.uid == uid &&
        other.serviceProviderId == serviceProviderId &&
        other.car == car &&
        other.location == location &&
        listEquals(other.technicianIds, technicianIds) &&
        listEquals(other.rating, rating) &&
        other.transaction == transaction &&
        other.selectedServices == selectedServices &&
        other.rejectionReason == rejectionReason &&
        other.isPaid == isPaid &&
        other.coupon == coupon &&
        other.useWallet == useWallet &&
        other.timeslot == timeslot &&
        other.isVisible == isVisible &&
        other.transactionId == transactionId &&
        listEquals(other.otherServices, otherServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        serviceProviderId.hashCode ^
        car.hashCode ^
        location.hashCode ^
        technicianIds.hashCode ^
        rating.hashCode ^
        transaction.hashCode ^
        selectedServices.hashCode ^
        rejectionReason.hashCode ^
        isPaid.hashCode ^
        coupon.hashCode ^
        useWallet.hashCode ^
        timeslot.hashCode ^
        otherServices.hashCode ^
        transactionId.hashCode ^
        isVisible.hashCode;
  }
}
