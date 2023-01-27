// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timeslot_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimeslotGroup {
  String get durationString => throw _privateConstructorUsedError;
  Timestamp get timeFrom => throw _privateConstructorUsedError;
  Timestamp get timeTo => throw _privateConstructorUsedError;
  List<Timeslot> get timeslots => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeslotGroupCopyWith<TimeslotGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeslotGroupCopyWith<$Res> {
  factory $TimeslotGroupCopyWith(
          TimeslotGroup value, $Res Function(TimeslotGroup) then) =
      _$TimeslotGroupCopyWithImpl<$Res>;
  $Res call(
      {String durationString,
      Timestamp timeFrom,
      Timestamp timeTo,
      List<Timeslot> timeslots});
}

/// @nodoc
class _$TimeslotGroupCopyWithImpl<$Res>
    implements $TimeslotGroupCopyWith<$Res> {
  _$TimeslotGroupCopyWithImpl(this._value, this._then);

  final TimeslotGroup _value;
  // ignore: unused_field
  final $Res Function(TimeslotGroup) _then;

  @override
  $Res call({
    Object? durationString = freezed,
    Object? timeFrom = freezed,
    Object? timeTo = freezed,
    Object? timeslots = freezed,
  }) {
    return _then(_value.copyWith(
      durationString: durationString == freezed
          ? _value.durationString
          : durationString // ignore: cast_nullable_to_non_nullable
              as String,
      timeFrom: timeFrom == freezed
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      timeTo: timeTo == freezed
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      timeslots: timeslots == freezed
          ? _value.timeslots
          : timeslots // ignore: cast_nullable_to_non_nullable
              as List<Timeslot>,
    ));
  }
}

/// @nodoc
abstract class _$$_TimeslotGroupCopyWith<$Res>
    implements $TimeslotGroupCopyWith<$Res> {
  factory _$$_TimeslotGroupCopyWith(
          _$_TimeslotGroup value, $Res Function(_$_TimeslotGroup) then) =
      __$$_TimeslotGroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {String durationString,
      Timestamp timeFrom,
      Timestamp timeTo,
      List<Timeslot> timeslots});
}

/// @nodoc
class __$$_TimeslotGroupCopyWithImpl<$Res>
    extends _$TimeslotGroupCopyWithImpl<$Res>
    implements _$$_TimeslotGroupCopyWith<$Res> {
  __$$_TimeslotGroupCopyWithImpl(
      _$_TimeslotGroup _value, $Res Function(_$_TimeslotGroup) _then)
      : super(_value, (v) => _then(v as _$_TimeslotGroup));

  @override
  _$_TimeslotGroup get _value => super._value as _$_TimeslotGroup;

  @override
  $Res call({
    Object? durationString = freezed,
    Object? timeFrom = freezed,
    Object? timeTo = freezed,
    Object? timeslots = freezed,
  }) {
    return _then(_$_TimeslotGroup(
      durationString: durationString == freezed
          ? _value.durationString
          : durationString // ignore: cast_nullable_to_non_nullable
              as String,
      timeFrom: timeFrom == freezed
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      timeTo: timeTo == freezed
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      timeslots: timeslots == freezed
          ? _value._timeslots
          : timeslots // ignore: cast_nullable_to_non_nullable
              as List<Timeslot>,
    ));
  }
}

/// @nodoc

class _$_TimeslotGroup implements _TimeslotGroup {
  _$_TimeslotGroup(
      {required this.durationString,
      required this.timeFrom,
      required this.timeTo,
      required final List<Timeslot> timeslots})
      : _timeslots = timeslots;

  @override
  final String durationString;
  @override
  final Timestamp timeFrom;
  @override
  final Timestamp timeTo;
  final List<Timeslot> _timeslots;
  @override
  List<Timeslot> get timeslots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeslots);
  }

  @override
  String toString() {
    return 'TimeslotGroup(durationString: $durationString, timeFrom: $timeFrom, timeTo: $timeTo, timeslots: $timeslots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimeslotGroup &&
            const DeepCollectionEquality()
                .equals(other.durationString, durationString) &&
            const DeepCollectionEquality().equals(other.timeFrom, timeFrom) &&
            const DeepCollectionEquality().equals(other.timeTo, timeTo) &&
            const DeepCollectionEquality()
                .equals(other._timeslots, _timeslots));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(durationString),
      const DeepCollectionEquality().hash(timeFrom),
      const DeepCollectionEquality().hash(timeTo),
      const DeepCollectionEquality().hash(_timeslots));

  @JsonKey(ignore: true)
  @override
  _$$_TimeslotGroupCopyWith<_$_TimeslotGroup> get copyWith =>
      __$$_TimeslotGroupCopyWithImpl<_$_TimeslotGroup>(this, _$identity);
}

abstract class _TimeslotGroup implements TimeslotGroup {
  factory _TimeslotGroup(
      {required final String durationString,
      required final Timestamp timeFrom,
      required final Timestamp timeTo,
      required final List<Timeslot> timeslots}) = _$_TimeslotGroup;

  @override
  String get durationString;
  @override
  Timestamp get timeFrom;
  @override
  Timestamp get timeTo;
  @override
  List<Timeslot> get timeslots;
  @override
  @JsonKey(ignore: true)
  _$$_TimeslotGroupCopyWith<_$_TimeslotGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
