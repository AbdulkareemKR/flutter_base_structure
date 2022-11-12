import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/models/transaction.dart';
import 'package:garage_core/services/services_services.dart';

final transactionProvider = FutureProvider.autoDispose.family<Transaction, String>((ref, transactionId) async {
  return await getTransaction(id: transactionId);
});
