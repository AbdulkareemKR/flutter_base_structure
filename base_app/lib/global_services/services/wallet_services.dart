import 'package:garage_core/models/wallet.dart';
import 'package:garage_core/services/firestore_services.dart';
import 'package:garage_core/utilis/logger/extensions.dart';

import '../enums/currency.dart';

String getCurrencyString(Currency currency) {
  final String currencyText;
  switch (currency) {
    case Currency.sar:
      currencyText = 'ر.س';
      break;
    default:
      currencyText = 'ر.س';
  }
  return currencyText;
}

Future<Wallet?> getUserWallet(String uid) async {
  try {
    final walletDocs = (await FirestoreServices.walletsCollection.where('uid', isEqualTo: uid).get()).docs;
    if (walletDocs.isNotEmpty) {
      final wallet = Wallet.fromMap(walletDocs.first.data());
      return wallet;
    }
  } catch (e) {
    e.logException();
  }
  return null;
}

Stream<Wallet?> getWalletStream(String uid) {
  try {
    final walletStream = FirestoreServices.walletsCollection.where('uid', isEqualTo: uid).snapshots().map((list) {
      final wallets = list.docs.map((doc) => Wallet.fromMap(doc.data())).toList();
      if (wallets.isNotEmpty) {
        return wallets.first;
      }
    });
    return walletStream;
  } catch (e) {
    e.logException();
    return const Stream.empty();
  }
}
