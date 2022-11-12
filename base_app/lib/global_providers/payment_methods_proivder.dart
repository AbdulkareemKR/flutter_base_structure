import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_core/enums/payment_method.dart';

final paymentMethodsProvider = Provider<List<PaymentMethod>>((ref) {
  return [
    /// TODO: add apple pay when it is implemented
    PaymentMethod.mada,
    PaymentMethod.visa,
  ];
});
