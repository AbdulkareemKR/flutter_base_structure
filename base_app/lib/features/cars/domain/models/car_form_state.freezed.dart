// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'car_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CarFormState _$CarFormStateFromJson(Map<String, dynamic> json) {
  return _CarFormState.fromJson(json);
}

/// @nodoc
mixin _$CarFormState {
  CarViewMode get viewMode => throw _privateConstructorUsedError;
  Translatable get carBrand => throw _privateConstructorUsedError;
  String get carType => throw _privateConstructorUsedError;
  Car? get selectedCar => throw _privateConstructorUsedError;
  CarColor? get selectedColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarFormStateCopyWith<CarFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarFormStateCopyWith<$Res> {
  factory $CarFormStateCopyWith(
          CarFormState value, $Res Function(CarFormState) then) =
      _$CarFormStateCopyWithImpl<$Res>;
  $Res call(
      {CarViewMode viewMode,
      Translatable carBrand,
      String carType,
      Car? selectedCar,
      CarColor? selectedColor});
}

/// @nodoc
class _$CarFormStateCopyWithImpl<$Res> implements $CarFormStateCopyWith<$Res> {
  _$CarFormStateCopyWithImpl(this._value, this._then);

  final CarFormState _value;
  // ignore: unused_field
  final $Res Function(CarFormState) _then;

  @override
  $Res call({
    Object? viewMode = freezed,
    Object? carBrand = freezed,
    Object? carType = freezed,
    Object? selectedCar = freezed,
    Object? selectedColor = freezed,
  }) {
    return _then(_value.copyWith(
      viewMode: viewMode == freezed
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as CarViewMode,
      carBrand: carBrand == freezed
          ? _value.carBrand
          : carBrand // ignore: cast_nullable_to_non_nullable
              as Translatable,
      carType: carType == freezed
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCar: selectedCar == freezed
          ? _value.selectedCar
          : selectedCar // ignore: cast_nullable_to_non_nullable
              as Car?,
      selectedColor: selectedColor == freezed
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as CarColor?,
    ));
  }
}

/// @nodoc
abstract class _$$_CarFormStateCopyWith<$Res>
    implements $CarFormStateCopyWith<$Res> {
  factory _$$_CarFormStateCopyWith(
          _$_CarFormState value, $Res Function(_$_CarFormState) then) =
      __$$_CarFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {CarViewMode viewMode,
      Translatable carBrand,
      String carType,
      Car? selectedCar,
      CarColor? selectedColor});
}

/// @nodoc
class __$$_CarFormStateCopyWithImpl<$Res>
    extends _$CarFormStateCopyWithImpl<$Res>
    implements _$$_CarFormStateCopyWith<$Res> {
  __$$_CarFormStateCopyWithImpl(
      _$_CarFormState _value, $Res Function(_$_CarFormState) _then)
      : super(_value, (v) => _then(v as _$_CarFormState));

  @override
  _$_CarFormState get _value => super._value as _$_CarFormState;

  @override
  $Res call({
    Object? viewMode = freezed,
    Object? carBrand = freezed,
    Object? carType = freezed,
    Object? selectedCar = freezed,
    Object? selectedColor = freezed,
  }) {
    return _then(_$_CarFormState(
      viewMode: viewMode == freezed
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as CarViewMode,
      carBrand: carBrand == freezed
          ? _value.carBrand
          : carBrand // ignore: cast_nullable_to_non_nullable
              as Translatable,
      carType: carType == freezed
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCar: selectedCar == freezed
          ? _value.selectedCar
          : selectedCar // ignore: cast_nullable_to_non_nullable
              as Car?,
      selectedColor: selectedColor == freezed
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as CarColor?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CarFormState implements _CarFormState {
  _$_CarFormState(
      {required this.viewMode,
      required this.carBrand,
      required this.carType,
      this.selectedCar,
      this.selectedColor});

  factory _$_CarFormState.fromJson(Map<String, dynamic> json) =>
      _$$_CarFormStateFromJson(json);

  @override
  final CarViewMode viewMode;
  @override
  final Translatable carBrand;
  @override
  final String carType;
  @override
  final Car? selectedCar;
  @override
  final CarColor? selectedColor;

  @override
  String toString() {
    return 'CarFormState(viewMode: $viewMode, carBrand: $carBrand, carType: $carType, selectedCar: $selectedCar, selectedColor: $selectedColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CarFormState &&
            const DeepCollectionEquality().equals(other.viewMode, viewMode) &&
            const DeepCollectionEquality().equals(other.carBrand, carBrand) &&
            const DeepCollectionEquality().equals(other.carType, carType) &&
            const DeepCollectionEquality()
                .equals(other.selectedCar, selectedCar) &&
            const DeepCollectionEquality()
                .equals(other.selectedColor, selectedColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(viewMode),
      const DeepCollectionEquality().hash(carBrand),
      const DeepCollectionEquality().hash(carType),
      const DeepCollectionEquality().hash(selectedCar),
      const DeepCollectionEquality().hash(selectedColor));

  @JsonKey(ignore: true)
  @override
  _$$_CarFormStateCopyWith<_$_CarFormState> get copyWith =>
      __$$_CarFormStateCopyWithImpl<_$_CarFormState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CarFormStateToJson(
      this,
    );
  }
}

abstract class _CarFormState implements CarFormState {
  factory _CarFormState(
      {required final CarViewMode viewMode,
      required final Translatable carBrand,
      required final String carType,
      final Car? selectedCar,
      final CarColor? selectedColor}) = _$_CarFormState;

  factory _CarFormState.fromJson(Map<String, dynamic> json) =
      _$_CarFormState.fromJson;

  @override
  CarViewMode get viewMode;
  @override
  Translatable get carBrand;
  @override
  String get carType;
  @override
  Car? get selectedCar;
  @override
  CarColor? get selectedColor;
  @override
  @JsonKey(ignore: true)
  _$$_CarFormStateCopyWith<_$_CarFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
