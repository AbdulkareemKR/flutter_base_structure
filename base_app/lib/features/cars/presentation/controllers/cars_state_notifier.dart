import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/features/cars/domain/enums/car_view_mode.dart';
import 'package:garage_client/features/cars/domain/models/car_form_state.dart';
import 'package:garage_client/features/cars/domain/providers/cars_provider.dart';
import 'package:garage_client/features/cars/domain/providers/color_page_index_provider.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/localization/localization.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_core/models/car.dart';
import 'package:garage_core/models/color.dart';
import 'package:garage_core/models/plate.dart';
import 'package:garage_core/models/translatable.dart';
import 'package:garage_core/models/user_car.dart';
import 'package:garage_core/services/car_services.dart';
import 'package:garage_core/utilis/logger/extensions.dart';

final carStateProvider =
    StateNotifierProvider.autoDispose.family<CarsStateNotifier, AsyncValue<CarFormState>, UserCar?>((ref, userCar) {
  return CarsStateNotifier(const AsyncLoading<CarFormState>(), oldCar: userCar, ref: ref);
});

class CarsStateNotifier extends StateNotifier<AsyncValue<CarFormState>> {
  CarsStateNotifier(state, {required this.oldCar, required this.ref}) : super(state) {
    init();
  }

  final Ref ref;

  final UserCar? oldCar;

  final PageController colorPageController = PageController();

  final lettersController = TextEditingController();
  final numbersController = TextEditingController();

  void init() async {
    colorPageController.addListener(() {
      ref.read(colorPageIndexProvider.state).state = colorPageController.page!.ceil();
    });
    ref.watch(carsProvider).when(
      data: (cars) async {
        if (oldCar != null) {
          final originalCar = await getCarFromId(oldCar!.carId!);

          lettersController.text = oldCar!.plate!.letters;
          numbersController.text = oldCar!.plate!.numbers;

          state = AsyncData(CarFormState(
              viewMode: CarViewMode.edit,
              carBrand: originalCar!.company,
              carType: originalCar.brand.translated,
              selectedCar: originalCar,
              selectedColor: oldCar!.color));
        } else {
          state = AsyncData(CarFormState(
              viewMode: CarViewMode.add,
              carBrand: cars.keys.first,
              carType: cars[cars.keys.first]!.first.brand.translated,
              selectedCar: cars[cars.keys.first]!.first));
        }
      },
      error: (error, stackTrace) {
        error.logException();
        state = AsyncError(error, StackTrace.current);
      },
      loading: () {
        state = const AsyncLoading();
      },
    );
  }

  void changeSelectedCarCompany(Translatable carCompany) {
    state.whenData((stateData) {
      state = AsyncData(stateData.copyWith(
          selectedCar: ref.read(carsProvider).asData?.value[carCompany]?.first,
          carBrand: carCompany,
          carType: ref.read(carsProvider).asData?.value[carCompany]?.first.brand.translated ?? ''));
    });
  }

  void changeSelectedCarBrand(Car car) {
    state.whenData((stateData) {
      state = AsyncData(stateData.copyWith(carType: car.brand.translated, selectedCar: car));
    });
  }

  void onColorClick(CarColor color) {
    state.whenData((stateData) {
      state = AsyncData(stateData.copyWith(selectedColor: color));
    });
  }

  Future<void> onSaveChangesClick(BuildContext context) async {
    state.whenData((stateData) async {
      try {
        final letters = Plate.arabicLettersToEgnlish(lettersController.text.replaceAll(' ', ''));
        final car = UserCar(
            id: oldCar!.id,
            uid: ref.watch(carOwnerProvider).asData?.value?.uid ?? '',
            carId: stateData.selectedCar!.id,
            color: stateData.selectedColor!,
            modelYear: '${oldCar?.modelYear ?? 2022}',
            plate: Plate(countryId: 'sa', letters: letters, numbers: numbersController.text));
        final success = await editCar(car);
        if (success) {
          Navigator.of(context).pop();
        } else {
          GarageDialog.show(context: context, style: DialogStyle.error, message: 'cars.unexpectedError'.translate());
        }
      } catch (e) {
        e.logException();
        GarageDialog.show(context: context, style: DialogStyle.error, message: 'cars.fillAllFields'.translate());
      }
    });
  }

  Future<void> onDeleteClick(BuildContext context) async {
    try {
      final confirm = await GarageDialog.showConfirmationDialog(
          context: context,
          title: 'cars.confirmDeleteCar',
          message: 'cars.confirmMessage',
          confirmText: 'cars.confirmButton',
          cancelText: 'cars.cancelButton');

      if (confirm ?? false) {
        await deleteCar(oldCar?.id ?? '');
        Navigator.of(context).pop();
        GarageDialog.show(context: context, style: DialogStyle.success, message: 'cars.carDeleted'.translate());
      }
    } catch (e) {
      e.logException();
      GarageDialog.show(context: context, style: DialogStyle.error, message: 'cars.unexpectedError'.translate());
    }
  }

  Future<void> onAddCarClick(BuildContext context) async {
    state.whenData((stateData) async {
      try {
        if (lettersController.text.isEmpty || numbersController.text.isEmpty) {
          throw Exception('fill all field');
        }
        final letters = Plate.arabicLettersToEgnlish(lettersController.text.replaceAll(' ', ''));
        final car = UserCar(
            uid: ref.watch(carOwnerProvider).asData?.value?.uid ?? '',
            carId: stateData.selectedCar!.id,
            color: stateData.selectedColor!,
            modelYear: '2022',
            plate: Plate(countryId: 'sa', letters: letters, numbers: numbersController.text));
        final success = await addNewCar(car);
        if (success) {
          Navigator.of(context).pop();
          GarageDialog.show(context: context, style: DialogStyle.success, message: 'cars.carAdded'.translate());
        } else {
          GarageDialog.show(context: context, style: DialogStyle.error, message: 'cars.unexpectedError'.translate());
        }
      } catch (e) {
        e.logException();

        GarageDialog.show(context: context, style: DialogStyle.error, message: 'cars.fillAllFields'.translate());
      }
    });
  }
}
