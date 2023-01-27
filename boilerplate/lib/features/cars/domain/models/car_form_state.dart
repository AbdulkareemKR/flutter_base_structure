import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_client/features/cars/domain/enums/car_view_mode.dart';
import 'package:garage_client/models/car.dart';
import 'package:garage_client/models/color.dart';
import 'package:garage_client/models/translatable.dart';

part 'car_form_state.freezed.dart';
part 'car_form_state.g.dart';

@freezed
class CarFormState with _$CarFormState {
  factory CarFormState({
    required CarViewMode viewMode,
    required Translatable carBrand,
    required String carType,
    Car? selectedCar,
    CarColor? selectedColor,
  }) = _CarFormState;

  factory CarFormState.fromJson(Map<String, dynamic> json) => _$CarFormStateFromJson(json);
}
