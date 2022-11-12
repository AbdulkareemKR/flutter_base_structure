import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/global_services/enums/payment_method.dart';
import 'package:garage_client/global_services/models/service.dart';
import 'package:garage_client/global_services/models/timeslot.dart';

part 'order_form_data.freezed.dart';
part 'order_form_data.g.dart';

@freezed
class OrderFormData with _$OrderFormData {
  factory OrderFormData({
    required Service? selectedService,
    Service? otherServices,
    String? date,
    String? notes,
    Timeslot? timeslot,
    required bool useWalletMoney,
    required PaymentMethod paymentMethod,
    required double totalPrice,
  }) = _OrderFormData;

  factory OrderFormData.fromJson(Map<String, dynamic> json) => _$OrderFormDataFromJson(json);
}
