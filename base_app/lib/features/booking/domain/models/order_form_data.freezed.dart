// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_form_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderFormData _$OrderFormDataFromJson(Map<String, dynamic> json) {
  return _OrderFormData.fromJson(json);
}

/// @nodoc
mixin _$OrderFormData {
  Service? get selectedService => throw _privateConstructorUsedError;
  Service? get otherServices => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Timeslot? get timeslot => throw _privateConstructorUsedError;
  bool get useWalletMoney => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderFormDataCopyWith<OrderFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderFormDataCopyWith<$Res> {
  factory $OrderFormDataCopyWith(
          OrderFormData value, $Res Function(OrderFormData) then) =
      _$OrderFormDataCopyWithImpl<$Res>;
  $Res call(
      {Service? selectedService,
      Service? otherServices,
      String? date,
      String? notes,
      Timeslot? timeslot,
      bool useWalletMoney,
      PaymentMethod paymentMethod,
      double totalPrice});
}

/// @nodoc
class _$OrderFormDataCopyWithImpl<$Res>
    implements $OrderFormDataCopyWith<$Res> {
  _$OrderFormDataCopyWithImpl(this._value, this._then);

  final OrderFormData _value;
  // ignore: unused_field
  final $Res Function(OrderFormData) _then;

  @override
  $Res call({
    Object? selectedService = freezed,
    Object? otherServices = freezed,
    Object? date = freezed,
    Object? notes = freezed,
    Object? timeslot = freezed,
    Object? useWalletMoney = freezed,
    Object? paymentMethod = freezed,
    Object? totalPrice = freezed,
  }) {
    return _then(_value.copyWith(
      selectedService: selectedService == freezed
          ? _value.selectedService
          : selectedService // ignore: cast_nullable_to_non_nullable
              as Service?,
      otherServices: otherServices == freezed
          ? _value.otherServices
          : otherServices // ignore: cast_nullable_to_non_nullable
              as Service?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timeslot: timeslot == freezed
          ? _value.timeslot
          : timeslot // ignore: cast_nullable_to_non_nullable
              as Timeslot?,
      useWalletMoney: useWalletMoney == freezed
          ? _value.useWalletMoney
          : useWalletMoney // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      totalPrice: totalPrice == freezed
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_OrderFormDataCopyWith<$Res>
    implements $OrderFormDataCopyWith<$Res> {
  factory _$$_OrderFormDataCopyWith(
          _$_OrderFormData value, $Res Function(_$_OrderFormData) then) =
      __$$_OrderFormDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Service? selectedService,
      Service? otherServices,
      String? date,
      String? notes,
      Timeslot? timeslot,
      bool useWalletMoney,
      PaymentMethod paymentMethod,
      double totalPrice});
}

/// @nodoc
class __$$_OrderFormDataCopyWithImpl<$Res>
    extends _$OrderFormDataCopyWithImpl<$Res>
    implements _$$_OrderFormDataCopyWith<$Res> {
  __$$_OrderFormDataCopyWithImpl(
      _$_OrderFormData _value, $Res Function(_$_OrderFormData) _then)
      : super(_value, (v) => _then(v as _$_OrderFormData));

  @override
  _$_OrderFormData get _value => super._value as _$_OrderFormData;

  @override
  $Res call({
    Object? selectedService = freezed,
    Object? otherServices = freezed,
    Object? date = freezed,
    Object? notes = freezed,
    Object? timeslot = freezed,
    Object? useWalletMoney = freezed,
    Object? paymentMethod = freezed,
    Object? totalPrice = freezed,
  }) {
    return _then(_$_OrderFormData(
      selectedService: selectedService == freezed
          ? _value.selectedService
          : selectedService // ignore: cast_nullable_to_non_nullable
              as Service?,
      otherServices: otherServices == freezed
          ? _value.otherServices
          : otherServices // ignore: cast_nullable_to_non_nullable
              as Service?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timeslot: timeslot == freezed
          ? _value.timeslot
          : timeslot // ignore: cast_nullable_to_non_nullable
              as Timeslot?,
      useWalletMoney: useWalletMoney == freezed
          ? _value.useWalletMoney
          : useWalletMoney // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      totalPrice: totalPrice == freezed
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderFormData implements _OrderFormData {
  _$_OrderFormData(
      {required this.selectedService,
      this.otherServices,
      this.date,
      this.notes,
      this.timeslot,
      required this.useWalletMoney,
      required this.paymentMethod,
      required this.totalPrice});

  factory _$_OrderFormData.fromJson(Map<String, dynamic> json) =>
      _$$_OrderFormDataFromJson(json);

  @override
  final Service? selectedService;
  @override
  final Service? otherServices;
  @override
  final String? date;
  @override
  final String? notes;
  @override
  final Timeslot? timeslot;
  @override
  final bool useWalletMoney;
  @override
  final PaymentMethod paymentMethod;
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'OrderFormData(selectedService: $selectedService, otherServices: $otherServices, date: $date, notes: $notes, timeslot: $timeslot, useWalletMoney: $useWalletMoney, paymentMethod: $paymentMethod, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderFormData &&
            const DeepCollectionEquality()
                .equals(other.selectedService, selectedService) &&
            const DeepCollectionEquality()
                .equals(other.otherServices, otherServices) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality().equals(other.timeslot, timeslot) &&
            const DeepCollectionEquality()
                .equals(other.useWalletMoney, useWalletMoney) &&
            const DeepCollectionEquality()
                .equals(other.paymentMethod, paymentMethod) &&
            const DeepCollectionEquality()
                .equals(other.totalPrice, totalPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(selectedService),
      const DeepCollectionEquality().hash(otherServices),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(notes),
      const DeepCollectionEquality().hash(timeslot),
      const DeepCollectionEquality().hash(useWalletMoney),
      const DeepCollectionEquality().hash(paymentMethod),
      const DeepCollectionEquality().hash(totalPrice));

  @JsonKey(ignore: true)
  @override
  _$$_OrderFormDataCopyWith<_$_OrderFormData> get copyWith =>
      __$$_OrderFormDataCopyWithImpl<_$_OrderFormData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderFormDataToJson(
      this,
    );
  }
}

abstract class _OrderFormData implements OrderFormData {
  factory _OrderFormData(
      {required final Service? selectedService,
      final Service? otherServices,
      final String? date,
      final String? notes,
      final Timeslot? timeslot,
      required final bool useWalletMoney,
      required final PaymentMethod paymentMethod,
      required final double totalPrice}) = _$_OrderFormData;

  factory _OrderFormData.fromJson(Map<String, dynamic> json) =
      _$_OrderFormData.fromJson;

  @override
  Service? get selectedService;
  @override
  Service? get otherServices;
  @override
  String? get date;
  @override
  String? get notes;
  @override
  Timeslot? get timeslot;
  @override
  bool get useWalletMoney;
  @override
  PaymentMethod get paymentMethod;
  @override
  double get totalPrice;
  @override
  @JsonKey(ignore: true)
  _$$_OrderFormDataCopyWith<_$_OrderFormData> get copyWith =>
      throw _privateConstructorUsedError;
}
