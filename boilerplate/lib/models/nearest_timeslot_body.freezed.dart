// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'nearest_timeslot_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NearestTimeslotBody {
  Service get service => throw _privateConstructorUsedError;
  List<Timeslot> get timeslots => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NearestTimeslotBodyCopyWith<NearestTimeslotBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearestTimeslotBodyCopyWith<$Res> {
  factory $NearestTimeslotBodyCopyWith(
          NearestTimeslotBody value, $Res Function(NearestTimeslotBody) then) =
      _$NearestTimeslotBodyCopyWithImpl<$Res, NearestTimeslotBody>;
  @useResult
  $Res call({Service service, List<Timeslot> timeslots});
}

/// @nodoc
class _$NearestTimeslotBodyCopyWithImpl<$Res, $Val extends NearestTimeslotBody>
    implements $NearestTimeslotBodyCopyWith<$Res> {
  _$NearestTimeslotBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? timeslots = null,
  }) {
    return _then(_value.copyWith(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service,
      timeslots: null == timeslots
          ? _value.timeslots
          : timeslots // ignore: cast_nullable_to_non_nullable
              as List<Timeslot>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NearestTimeslotBodyCopyWith<$Res>
    implements $NearestTimeslotBodyCopyWith<$Res> {
  factory _$$_NearestTimeslotBodyCopyWith(_$_NearestTimeslotBody value,
          $Res Function(_$_NearestTimeslotBody) then) =
      __$$_NearestTimeslotBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Service service, List<Timeslot> timeslots});
}

/// @nodoc
class __$$_NearestTimeslotBodyCopyWithImpl<$Res>
    extends _$NearestTimeslotBodyCopyWithImpl<$Res, _$_NearestTimeslotBody>
    implements _$$_NearestTimeslotBodyCopyWith<$Res> {
  __$$_NearestTimeslotBodyCopyWithImpl(_$_NearestTimeslotBody _value,
      $Res Function(_$_NearestTimeslotBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? timeslots = null,
  }) {
    return _then(_$_NearestTimeslotBody(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service,
      timeslots: null == timeslots
          ? _value._timeslots
          : timeslots // ignore: cast_nullable_to_non_nullable
              as List<Timeslot>,
    ));
  }
}

/// @nodoc

class _$_NearestTimeslotBody implements _NearestTimeslotBody {
  _$_NearestTimeslotBody(
      {required this.service, required final List<Timeslot> timeslots})
      : _timeslots = timeslots;

  @override
  final Service service;
  final List<Timeslot> _timeslots;
  @override
  List<Timeslot> get timeslots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeslots);
  }

  @override
  String toString() {
    return 'NearestTimeslotBody(service: $service, timeslots: $timeslots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearestTimeslotBody &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other._timeslots, _timeslots));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, service, const DeepCollectionEquality().hash(_timeslots));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearestTimeslotBodyCopyWith<_$_NearestTimeslotBody> get copyWith =>
      __$$_NearestTimeslotBodyCopyWithImpl<_$_NearestTimeslotBody>(
          this, _$identity);
}

abstract class _NearestTimeslotBody implements NearestTimeslotBody {
  factory _NearestTimeslotBody(
      {required final Service service,
      required final List<Timeslot> timeslots}) = _$_NearestTimeslotBody;

  @override
  Service get service;
  @override
  List<Timeslot> get timeslots;
  @override
  @JsonKey(ignore: true)
  _$$_NearestTimeslotBodyCopyWith<_$_NearestTimeslotBody> get copyWith =>
      throw _privateConstructorUsedError;
}
