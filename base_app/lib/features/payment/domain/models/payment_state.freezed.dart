// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentState _$PaymentStateFromJson(Map<String, dynamic> json) {
  return _PaymentState.fromJson(json);
}

/// @nodoc
mixin _$PaymentState {
  double? get amount => throw _privateConstructorUsedError;
  String? get cardNumber => throw _privateConstructorUsedError;
  String? get cardHolderName => throw _privateConstructorUsedError;
  String? get expDate => throw _privateConstructorUsedError;
  String? get cvv => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentStateCopyWith<PaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
          PaymentState value, $Res Function(PaymentState) then) =
      _$PaymentStateCopyWithImpl<$Res>;
  $Res call(
      {double? amount,
      String? cardNumber,
      String? cardHolderName,
      String? expDate,
      String? cvv});
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res> implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  final PaymentState _value;
  // ignore: unused_field
  final $Res Function(PaymentState) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? cardNumber = freezed,
    Object? cardHolderName = freezed,
    Object? expDate = freezed,
    Object? cvv = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      cardNumber: cardNumber == freezed
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      cardHolderName: cardHolderName == freezed
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      expDate: expDate == freezed
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cvv: cvv == freezed
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_PaymentStateCopyWith<$Res>
    implements $PaymentStateCopyWith<$Res> {
  factory _$$_PaymentStateCopyWith(
          _$_PaymentState value, $Res Function(_$_PaymentState) then) =
      __$$_PaymentStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {double? amount,
      String? cardNumber,
      String? cardHolderName,
      String? expDate,
      String? cvv});
}

/// @nodoc
class __$$_PaymentStateCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res>
    implements _$$_PaymentStateCopyWith<$Res> {
  __$$_PaymentStateCopyWithImpl(
      _$_PaymentState _value, $Res Function(_$_PaymentState) _then)
      : super(_value, (v) => _then(v as _$_PaymentState));

  @override
  _$_PaymentState get _value => super._value as _$_PaymentState;

  @override
  $Res call({
    Object? amount = freezed,
    Object? cardNumber = freezed,
    Object? cardHolderName = freezed,
    Object? expDate = freezed,
    Object? cvv = freezed,
  }) {
    return _then(_$_PaymentState(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      cardNumber: cardNumber == freezed
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      cardHolderName: cardHolderName == freezed
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      expDate: expDate == freezed
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cvv: cvv == freezed
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentState implements _PaymentState {
  _$_PaymentState(
      {this.amount,
      this.cardNumber,
      this.cardHolderName,
      this.expDate,
      this.cvv});

  factory _$_PaymentState.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentStateFromJson(json);

  @override
  final double? amount;
  @override
  final String? cardNumber;
  @override
  final String? cardHolderName;
  @override
  final String? expDate;
  @override
  final String? cvv;

  @override
  String toString() {
    return 'PaymentState(amount: $amount, cardNumber: $cardNumber, cardHolderName: $cardHolderName, expDate: $expDate, cvv: $cvv)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentState &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.cardNumber, cardNumber) &&
            const DeepCollectionEquality()
                .equals(other.cardHolderName, cardHolderName) &&
            const DeepCollectionEquality().equals(other.expDate, expDate) &&
            const DeepCollectionEquality().equals(other.cvv, cvv));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(cardNumber),
      const DeepCollectionEquality().hash(cardHolderName),
      const DeepCollectionEquality().hash(expDate),
      const DeepCollectionEquality().hash(cvv));

  @JsonKey(ignore: true)
  @override
  _$$_PaymentStateCopyWith<_$_PaymentState> get copyWith =>
      __$$_PaymentStateCopyWithImpl<_$_PaymentState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentStateToJson(
      this,
    );
  }
}

abstract class _PaymentState implements PaymentState {
  factory _PaymentState(
      {final double? amount,
      final String? cardNumber,
      final String? cardHolderName,
      final String? expDate,
      final String? cvv}) = _$_PaymentState;

  factory _PaymentState.fromJson(Map<String, dynamic> json) =
      _$_PaymentState.fromJson;

  @override
  double? get amount;
  @override
  String? get cardNumber;
  @override
  String? get cardHolderName;
  @override
  String? get expDate;
  @override
  String? get cvv;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentStateCopyWith<_$_PaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}
