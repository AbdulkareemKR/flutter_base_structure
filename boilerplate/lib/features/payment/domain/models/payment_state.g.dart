// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentState _$$_PaymentStateFromJson(Map<String, dynamic> json) =>
    _$_PaymentState(
      amount: (json['amount'] as num?)?.toDouble(),
      cardNumber: json['cardNumber'] as String?,
      cardHolderName: json['cardHolderName'] as String?,
      expDate: json['expDate'] as String?,
      cvv: json['cvv'] as String?,
    );

Map<String, dynamic> _$$_PaymentStateToJson(_$_PaymentState instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'expDate': instance.expDate,
      'cvv': instance.cvv,
    };
