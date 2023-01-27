import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/models/transaction.dart';
import 'package:garage_client/models/wallet.dart';
import 'package:garage_client/services/date_time_repo.dart';

final walletControllerProvider = StateProvider<WalletController>((ref) => WalletController(ref: ref));

class WalletController {
  final Ref ref;

  WalletController({required this.ref});

  Wallet? sortTransaction(Wallet? wallet) {
    wallet?.transactions.sort((transactionItem1, transactionItem2) {
      return transactionItem2.paymentDate.compareTo(transactionItem1.paymentDate);
    });
    return wallet;
  }

  String getTransactionTime(Transaction transaction) {
    return '${ref.read(dateTimeRepo).getDateFormatted(transaction.paymentDate)} • ${ref.read(dateTimeRepo).getDate12HFormatted(transaction.paymentDate)}';
  }
}
