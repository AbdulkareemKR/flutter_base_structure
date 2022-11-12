import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/features/booking/domain/models/order_form_data.dart';
import 'package:garage_client/features/booking/domain/providers/sub_services_provider.dart';
import 'package:garage_client/features/booking/domain/providers/timelosts_future_provider.dart';
import 'package:garage_client/features/booking/domain/providers/timeslots_provider.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen_form.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/global_providers/payment_methods_proivder.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_client/global_services/models/async_response/async_response.dart';
import 'package:garage_client/global_services/models/cloud_function_response.dart';
import 'package:garage_client/global_services/models/order.dart';
import 'package:garage_client/global_services/models/service.dart';
import 'package:garage_client/global_services/models/timeslot.dart';
import 'package:garage_client/global_services/models/transaction.dart';
import 'package:garage_client/global_services/services/date_time_repo.dart';
import 'package:garage_client/global_services/services/services_repo.dart';
import 'package:garage_client/global_services/services/services_services.dart';
import 'package:garage_client/global_services/services/timeslot_repo.dart';
import 'package:garage_client/global_services/services/timeslots_services.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/global_services/models/locale_response/locale_response.dart';

final orderFormProvider =
    StateNotifierProvider.family.autoDispose<OrderFormNotifier, AsyncValue<OrderFormData>, String>((ref, serviceId) {
  return OrderFormNotifier(ref: ref, serviceId: serviceId);
});

final initOrderProvider = StateProvider<Order?>((ref) {
  return null;
});

class OrderFormNotifier extends StateNotifier<AsyncValue<OrderFormData>> {
  OrderFormNotifier({required this.ref, required this.serviceId}) : super(const AsyncLoading()) {
    init();
  }

  final Ref ref;
  final String serviceId;

  void init() async {
    ref.watch(subServicesProvider(serviceId)).when(data: ((services) async {
      try {
        final carOwner = await ref.watch(carOwnerProvider.future);
        final nearestTimeslot =
            await ref.read(timeslotsRepoProvider).getNearestTimeslot(services, carOwner!.defaultCar!);

        log(nearestTimeslot['timeslot'].toString());
        final Timeslot? timeslot;
        final double totalPrice;
        if (nearestTimeslot.containsKey('timeslot') && ((nearestTimeslot['timeslot'] as List).isNotEmpty)) {
          timeslot = nearestTimeslot['timeslot'].first as Timeslot;
        } else {
          timeslot = null;
        }
        if (timeslot != null) {
          totalPrice = (await getServicePriceForServiceProvider(
                  timeslot.serviceId, timeslot.serviceProviderId, ref.watch(carOwnerProvider).value?.defaultCar?.carId))
              .toDouble();
        } else {
          totalPrice = 0.0;
        }

        state = AsyncData(OrderFormData(

            /// Getting the selected services that have available timeslots
            selectedService: nearestTimeslot['service'],

            ///Getting the first timeslots
            timeslot: timeslot,
            totalPrice: totalPrice,

            /// We are reading the provider here to ensure unexpected rebuild
            /// it should not happen also because it is of type [Provider]
            paymentMethod: ref.read(paymentMethodsProvider).first,

            /// The default of using wallet is false
            useWalletMoney: false,

            /// Getting the first key which is the day.
            date: timeslot != null
                ? ref.read(dateTimeRepo).getDayNameAndNumber(timeslot.dateFrom.toDate(), App.localeCode)
                : null));
      } catch (error) {
        log('$error');

        state = AsyncError(error, StackTrace.current);
      }
    }), error: ((error, stackTrace) {
      log('$error');

      state = AsyncError(error, stackTrace);
    }), loading: () {
      state = const AsyncLoading();
    });
  }

  void changeSelectedService(Service service) async {
    state.whenData(((value) {
      state = AsyncData(value.copyWith(selectedService: service, otherServices: null));
    }));

    ///
    /// Re update the chosen timeslot based on the new service.
    ///
    ref.read(validServiceProvidersProvider.state).state = [];
    await updateTimeslot(service.id);
    await updateTotalPrice();
  }

  void changeSelectedOtherService(Service? service) async {
    state.whenData(((value) async {
      state = AsyncData(value.copyWith(otherServices: service));
    }));

    if (service != null) {
      ref.read(validServiceProvidersProvider.state).state =
          await ref.read(servicesRepoProvider).getServiceProvidersForService(service.id);
    } else {
      ref.read(validServiceProvidersProvider.state).state = [];
    }
    await updateTimeslot(state.asData?.value.selectedService?.id ?? '');
    await updateTotalPrice();
  }

  void changeSelectedDate(String? date) {
    state.whenData(((value) {
      state = AsyncData(value.copyWith(date: date, timeslot: null));
    }));
  }

  void changeSelectedTimeslot(Timeslot timeslot) {
    state.whenData(((value) {
      state = AsyncData(value.copyWith(timeslot: timeslot));
    }));

    updateTotalPrice();
  }

  Future<void> updateTimeslot(String serviceId) async {
    final carOwner = await ref.read(carOwnerProvider.future);
    if (carOwner == null) return;

    final timeslots = await ref.read(getTimeslotsProvider(serviceId, carOwner.defaultCar!).future);
    state.whenData(((value) {
      if (timeslots.isNotEmpty) {
        state = AsyncData(
            value.copyWith(timeslot: timeslots.values.first.first.timeslots.first, date: timeslots.keys.first));
      } else {
        state = AsyncData(value.copyWith(timeslot: null, date: null));
      }
    }));
  }

  void toggleUseWalletMoney() {
    state.whenData((orderInfo) {
      state = AsyncData(orderInfo.copyWith(useWalletMoney: !orderInfo.useWalletMoney));
    });
  }

  void changePaymentMethod(PaymentMethod paymentMethod) {
    state.whenData((orderInfo) {
      state = AsyncData(orderInfo.copyWith(paymentMethod: paymentMethod));
    });
  }

  Future<void> updateTotalPrice() async {
    double totalPrice = 0.0;

    state.whenData((orderInfo) async {
      log(orderInfo.otherServices.toString());
      if (orderInfo.timeslot != null) {
        totalPrice += (await getServicePriceForServiceProvider(orderInfo.timeslot!.serviceId,
            orderInfo.timeslot!.serviceProviderId, ref.watch(carOwnerProvider).value?.defaultCar?.carId));
      }

      if (orderInfo.otherServices != null) {
        totalPrice += (await getServicePriceForServiceProvider(orderInfo.otherServices!.id,
            orderInfo.timeslot!.serviceProviderId, ref.watch(carOwnerProvider).value?.defaultCar?.carId));
      }

      log(totalPrice.toString());
      state = AsyncData(orderInfo.copyWith(totalPrice: totalPrice));
    });
  }

  String get durationString => state.maybeWhen(
        orElse: () => '',
        data: (data) {
          if (data.timeslot != null) {
            return getDurationAsString(data.timeslot!.dateFrom, data.timeslot!.dateTo, App.localeCode);
          } else {
            return '';
          }
        },
      );

  Future<void> onPayPressed(BuildContext context) async {
    try {
      final initOrderResponse = await initOrder();

      if (initOrderResponse?.success ?? false) {
        ref
            .read(bookingPageControllerProvider)
            .animateToPage(2, duration: const Duration(milliseconds: 200), curve: Curves.easeInBack);
      } else {
        GarageDialog.show(
          context: context,
          style: DialogStyle.error,
          message: initOrderResponse?.message ?? 'orders.orderInitError'.translate(),
        );
      }
    } catch (e) {
      log(e.toString());
      GarageDialog.show(context: context, style: DialogStyle.error, message: 'orders.orderInitError'.translate());
    }
  }

  Future<AsyncResponse?> initOrder() async {
    try {
      final orderInfo = state.asData?.value;
      if (orderInfo == null) {
        return LocaleResponse(success: false, message: "orders.orderInfoIsNotComplete".translate(), data: null);
      }
      if (orderInfo.timeslot != null) {
        final initiatedOrder = Order(
            id: '',
            uid: ref.read(carOwnerProvider).asData!.value!.uid,
            serviceProviderId: orderInfo.timeslot!.serviceProviderId,
            car: ref.read(carOwnerProvider).asData!.value!.defaultCar!,
            location: ref.read(carOwnerProvider).asData!.value!.defaultLocation!,
            note: orderInfo.notes ?? '',
            status: OrderStatus.underProcessing,
            selectedServices: [orderInfo.selectedService!],
            isPaid: false,
            transaction: Transaction(
                paymentStatus: PaymentStatus.underProcessing,
                type: TransactionType.withdrawal,
                currency: Currency.sar,
                paymentMethod: orderInfo.paymentMethod,
                uid: ref.read(carOwnerProvider).asData!.value!.uid,
                paidTo: orderInfo.timeslot!.serviceProviderId,
                paymentDate: DateTime.now()),
            useWallet: orderInfo.useWalletMoney,
            timeslot: orderInfo.timeslot!,
            otherServices: [orderInfo.otherServices]);

        ref.read(initOrderProvider.notifier).state = initiatedOrder;

        return null;
      } else {
        return LocaleResponse(success: false, message: "orders.timeSlotError".translate());
      }
    } catch (e) {
      rethrow;
    }
  }

  bool get didSelectDate => state.maybeWhen(orElse: (() => false), data: ((data) => data.date != null));

  bool get didSelectTimeslot => state.maybeWhen(orElse: (() => false), data: ((data) => data.timeslot != null));

  bool get showTimePicker => didSelectDate && !didSelectTimeslot;
}
