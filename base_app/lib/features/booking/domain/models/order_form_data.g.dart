// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderFormData _$$_OrderFormDataFromJson(Map<String, dynamic> json) =>
    _$_OrderFormData(
      selectedService: json['selectedService'] == null
          ? null
          : Service.fromJson(json['selectedService'] as String),
      otherServices: json['otherServices'] == null
          ? null
          : Service.fromJson(json['otherServices'] as String),
      date: json['date'] as String?,
      notes: json['notes'] as String?,
      timeslot: json['timeslot'] == null
          ? null
          : Timeslot.fromJson(json['timeslot'] as String),
      useWalletMoney: json['useWalletMoney'] as bool,
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$_OrderFormDataToJson(_$_OrderFormData instance) =>
    <String, dynamic>{
      'selectedService': instance.selectedService,
      'otherServices': instance.otherServices,
      'date': instance.date,
      'notes': instance.notes,
      'timeslot': instance.timeslot,
      'useWalletMoney': instance.useWalletMoney,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'totalPrice': instance.totalPrice,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.visa: 'visa',
  PaymentMethod.masterCard: 'masterCard',
  PaymentMethod.applePay: 'applePay',
  PaymentMethod.stcPay: 'stcPay',
  PaymentMethod.giftCard: 'giftCard',
  PaymentMethod.walletMoney: 'walletMoney',
  PaymentMethod.mada: 'mada',
};
