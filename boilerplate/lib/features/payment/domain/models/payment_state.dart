import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';
part 'payment_state.g.dart';

@freezed
class PaymentState with _$PaymentState {
  factory PaymentState({
    double? amount,
    String? cardNumber,
    String? cardHolderName,
    String? expDate,
    String? cvv,
  }) = _PaymentState;

  factory PaymentState.fromJson(Map<String, dynamic> json) => _$PaymentStateFromJson(json);
}
