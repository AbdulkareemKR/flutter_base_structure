import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/models/wallet.dart';

final walletProvider = StreamProvider<Wallet?>((ref) {
  return ref.watch(carOwnerProvider).maybeWhen(
        data: (carOwner) => getWalletStream(carOwner?.uid ?? ''),
        orElse: () => const Stream.empty(),
      );
});