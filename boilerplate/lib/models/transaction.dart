import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_client/enums/currency.dart';
import 'package:garage_client/enums/payment_method.dart';
import 'package:garage_client/enums/payment_status.dart';
import 'package:garage_client/enums/transaction_type.dart';
import 'package:garage_client/models/flutter_timestamp.dart';
import 'package:garage_client/services/enum_services.dart';

export 'package:garage_client/enums/payment_method.dart';
export 'package:garage_client/enums/payment_status.dart';
export 'package:garage_client/enums/transaction_type.dart';
export 'package:garage_client/enums/currency.dart';

class Transaction {
  // Basic transaction info
  String? id;
  // User id.
  String uid;
  String? paidTo;
  DateTime paymentDate;
  Currency currency;
  String? paymentGatewayTransactionId;
  String? receiptId;
  bool? isMiddleTransaction;

// Paid amount related fields
  double? amount;
  double? vatAmount;
  double? vatPercent;
  double? rawAmount;
  double? finalAmount;

// enums fields
  TransactionType type;
  PaymentMethod paymentMethod;
  PaymentStatus paymentStatus;
  Transaction({
    this.id,
    required this.uid,
    required this.paidTo,
    required this.paymentDate,
    required this.currency,
    this.paymentGatewayTransactionId,
    this.amount,
    this.vatAmount,
    this.vatPercent,
    this.rawAmount,
    this.finalAmount,
    required this.type,
    required this.paymentMethod,
    required this.paymentStatus,
    this.isMiddleTransaction,
    this.receiptId,
  });

  Transaction copyWith({
    String? id,
    String? uid,
    String? paidTo,
    DateTime? paymentDate,
    Currency? currency,
    String? paymentGatewayTransactionId,
    double? amount,
    double? vatAmount,
    double? vatPercent,
    double? rawAmount,
    double? finalAmount,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    TransactionType? type,
    String? receiptId,
    bool? isMiddleTransaction,
  }) {
    return Transaction(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      paidTo: paidTo ?? this.paidTo,
      paymentDate: paymentDate ?? this.paymentDate,
      currency: currency ?? this.currency,
      paymentGatewayTransactionId: paymentGatewayTransactionId ?? this.paymentGatewayTransactionId,
      amount: amount ?? this.amount,
      vatAmount: vatAmount ?? this.vatAmount,
      vatPercent: vatPercent ?? this.vatPercent,
      rawAmount: rawAmount ?? this.rawAmount,
      finalAmount: finalAmount ?? this.finalAmount,
      type: type ?? this.type,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      receiptId: receiptId ?? this.receiptId,
      isMiddleTransaction: isMiddleTransaction ?? this.isMiddleTransaction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'paidTo': paidTo,
      'paymentDate': FlutterTimestamp.toMap(Timestamp.fromDate(paymentDate)),
      'currency': currency.name,
      'paymentGatewayTransactionId': paymentGatewayTransactionId,
      'amount': amount,
      'vatAmount': vatAmount,
      'vatPercent': vatPercent,
      'rawAmount': rawAmount,
      'finalAmount': finalAmount,
      'type': type.name,
      'paymentMethod': paymentMethod.name,
      'paymentStatus': paymentStatus.name,
      'receiptId': receiptId,
      'isMiddleTransaction': isMiddleTransaction,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    try {
      return Transaction(
        id: map['id'] != null ? map['id'] as String : null,
        uid: map['uid'] as String,
        paymentDate: (FlutterTimestamp.parse(map['paymentDate'])).toDate(),
        paidTo: map['paidTo'] != null ? map['paidTo'] as String : null,
        currency: enumFromString(Currency.values, map['currency'] as String),
        paymentGatewayTransactionId:
            map['paymentGatewayTransactionId'] != null ? map['paymentGatewayTransactionId'] as String : null,
        amount: map['amount'] != null ? double.tryParse('${map['amount']}') as double : null,
        vatAmount: map['vatAmount'] != null ? double.tryParse('${map['vatAmount']}') as double : null,
        vatPercent: map['vatPercent'] != null ? double.tryParse('${map['vatPercent']}') as double : null,
        rawAmount: map['rawAmount'] != null ? double.tryParse('${map['rawAmount']}') as double : null,
        finalAmount: map['finalAmount'] != null ? double.tryParse('${map['finalAmount']}') as double : null,
        paymentMethod: enumFromString(PaymentMethod.values, map['paymentMethod']),
        paymentStatus: enumFromString(PaymentStatus.values, map['paymentStatus']),
        type: enumFromString(TransactionType.values, map['type']),
        receiptId: map['receiptId'] != null ? "$map['receiptId']" : null,
        isMiddleTransaction: map['isMiddleTransaction'] != null ? map['isMiddleTransaction'] as bool : null,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, uid: $uid, paidTo: $paidTo, paymentDate: $paymentDate, currency: $currency, paymentGatewayTransactionId: $paymentGatewayTransactionId, amount: $amount, vatAmount: $vatAmount, vatPercent: $vatPercent, rawAmount: $rawAmount, finalAmount: $finalAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, receiptId: $receiptId)';
  }

  static toListOfMap(List<Transaction> transactions) {
    transactions.map((e) => e.toMap()).toList();
  }

  static transactionsListFromMap(List<dynamic> map) {
    return map.map((e) => Transaction.fromMap(e)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.uid == uid &&
        other.paidTo == paidTo &&
        other.paymentDate == paymentDate &&
        other.currency == currency &&
        other.paymentGatewayTransactionId == paymentGatewayTransactionId &&
        other.amount == amount &&
        other.vatAmount == vatAmount &&
        other.vatPercent == vatPercent &&
        other.rawAmount == rawAmount &&
        other.finalAmount == finalAmount &&
        other.paymentMethod == paymentMethod &&
        other.paymentStatus == paymentStatus &&
        other.receiptId == receiptId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        paidTo.hashCode ^
        paymentDate.hashCode ^
        currency.hashCode ^
        paymentGatewayTransactionId.hashCode ^
        amount.hashCode ^
        vatAmount.hashCode ^
        vatPercent.hashCode ^
        rawAmount.hashCode ^
        finalAmount.hashCode ^
        paymentMethod.hashCode ^
        paymentStatus.hashCode ^
        receiptId.hashCode;
  }
}
