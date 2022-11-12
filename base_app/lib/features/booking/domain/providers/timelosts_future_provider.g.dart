// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timelosts_future_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $getTimeslotsHash() => r'783ca2190b1bdffd4af9dba850ea1c96d0fb5a09';

/// See also [getTimeslots].
class GetTimeslotsProvider
    extends AutoDisposeFutureProvider<Map<String, List<TimeslotGroup>>> {
  GetTimeslotsProvider(
    this.serviceId,
    this.car,
  ) : super(
          (ref) => getTimeslots(
            ref,
            serviceId,
            car,
          ),
          from: getTimeslotsProvider,
          name: r'getTimeslotsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getTimeslotsHash,
        );

  final String? serviceId;
  final UserCar car;

  @override
  bool operator ==(Object other) {
    return other is GetTimeslotsProvider &&
        other.serviceId == serviceId &&
        other.car == car;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceId.hashCode);
    hash = _SystemHash.combine(hash, car.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetTimeslotsRef
    = AutoDisposeFutureProviderRef<Map<String, List<TimeslotGroup>>>;

/// See also [getTimeslots].
final getTimeslotsProvider = GetTimeslotsFamily();

class GetTimeslotsFamily
    extends Family<AsyncValue<Map<String, List<TimeslotGroup>>>> {
  GetTimeslotsFamily();

  GetTimeslotsProvider call(
    String? serviceId,
    UserCar car,
  ) {
    return GetTimeslotsProvider(
      serviceId,
      car,
    );
  }

  @override
  AutoDisposeFutureProvider<Map<String, List<TimeslotGroup>>>
      getProviderOverride(
    covariant GetTimeslotsProvider provider,
  ) {
    return call(
      provider.serviceId,
      provider.car,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getTimeslotsProvider';
}
