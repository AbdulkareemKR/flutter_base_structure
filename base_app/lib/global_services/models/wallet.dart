import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:garage_core/enums/currency.dart';
import 'package:garage_core/models/transaction.dart';
import 'package:garage_core/services/enum_services.dart';

export 'package:garage_core/services/wallet_services.dart';

class Wallet extends ChangeNotifier {
  // default wallet id
  String id;
  // the id of the user who owns this wallet
  String uid;
  // money in the wallet
  double amount;
  // currency of the wallet
  Currency currency;
  List<Transaction> transactions;
  Wallet({
    required this.id,
    required this.uid,
    required this.amount,
    required this.transactions,
    required this.currency,
  });

  Wallet copyWith({
    String? id,
    String? uid,
    double? amount,
    List<Transaction>? transactions,
    Currency? currency,
  }) {
    return Wallet(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      amount: amount ?? this.amount,
      transactions: transactions ?? this.transactions,
      currency: currency ?? this.currency,
    );
  }

  void addMoney(double amountToAdd) {
    // This function change the amount locally.
    // TODO: implement endpoint to handle adding money to user's wallets
    amount += amountToAdd;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'amount': amount,
      'transactions': Transaction.toListOfMap(transactions),
      'currency': enumToString(currency),
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
        id: map['id'] as String,
        uid: map['uid'] as String,
        amount: (map['amount'] as num).toDouble(),
        transactions: Transaction.transactionsListFromMap(map['transactions']),
        currency: enumFromString(Currency.values, map['currency'] as String));
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Wallet(id: $id, uid: $uid, amount: $amount, transactions: $transactions, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Wallet &&
        other.id == id &&
        other.uid == uid &&
        other.amount == amount &&
        listEquals(other.transactions, transactions) &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^ uid.hashCode ^ amount.hashCode ^ transactions.hashCode ^ currency.hashCode;
  }
}
