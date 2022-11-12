import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_data.freezed.dart';
part 'checkout_data.g.dart';

@freezed
class CheckoutData with _$CheckoutData {
  factory CheckoutData({
    required String checkoutId,
    required num amount,
  }) = _CheckoutData;

  factory CheckoutData.fromJson(Map<String, dynamic> json) => _$CheckoutDataFromJson(json);
}
