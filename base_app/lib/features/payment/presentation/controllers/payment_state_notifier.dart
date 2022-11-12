import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage_client/app.dart';
import 'package:garage_client/features/booking/domain/providers/order_from_state_notifier.dart';
import 'package:garage_client/features/orders/presentation/screens/orders_screen.dart';
import 'package:garage_client/features/payment/domain/models/payment_state.dart';
import 'package:garage_client/features/payment/domain/providers/error_provider.dart';
import 'package:garage_client/global_providers/car_owner_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/widgets/animated_dialog.dart';
import 'package:garage_core/enums/payment_method.dart';
import 'package:garage_core/models/async_response/async_response.dart';
import 'package:garage_core/models/locale_response/locale_response.dart';
import 'package:garage_core/services/auth_services.dart';
import 'package:garage_core/services/cloud_functions_services.dart';
import 'package:garage_core/services/easy_navigator.dart';
import 'package:garage_core/utilis/logger/g_logger.dart';
import 'package:hyperpay/hyperpay.dart';
import 'package:http/http.dart';

final paymentStateProvider = StateNotifierProvider<PaymentStateNotifier, AsyncValue<PaymentState>>((ref) {
  return PaymentStateNotifier(state: const AsyncLoading(), ref: ref);
});

class PaymentStateNotifier extends StateNotifier<AsyncValue<PaymentState>> {
  PaymentStateNotifier({required AsyncValue<PaymentState> state, this.checkoutId, required this.ref}) : super(state);

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expDateController = TextEditingController();

  String? checkoutId;
  bool isFirstPayment = true;

  final Ref ref;

  Future<AsyncResponse?> prepareHyperpay() async {
    try {
      final order = ref.read(initOrderProvider);
      final carOwner = ref.read(carOwnerProvider).asData?.value;
      if (carOwner == null || order == null) {
        return LocaleResponse(success: false, message: "errors.notSignedIn".translate(), data: null);
      }

      final Map<String, dynamic> requestBody = order.toCallableRequest();
      final carOwnerNameList = carOwner.name.split(' ');
      requestBody['otherServices'] = [];
      requestBody['id'] = '';
      requestBody['uid'] = carOwner.uid;
      requestBody['checkout'] = {
        "customer.givenName": carOwnerNameList.first,
        "customer.surname": carOwnerNameList.length > 1 ? carOwnerNameList[1] : carOwnerNameList.first,
        "customer.email": "payment@tryGarage.com",
        "customer.mobile": carOwner.phoneNumber,
        "billing.street1": "khobar",
        "billing.city": "khobar",
        "billing.state": "Eastren",
        "billing.country": "SA",
        "billing.postcode": "34227",
      };
      requestBody["lang"] = App.lang;

      log(requestBody.toString());
      final getCheckoutFunction =
          await CloudFunctionsServices.call(functionName: 'createOrder', arguments: requestBody);
      if (getCheckoutFunction?.data != null) {
        if (getCheckoutFunction!.success) {
          checkoutId = getCheckoutFunction.data['transaction']['paymentGatewayTransactionId'];

          state = AsyncData(
              PaymentState(amount: double.tryParse(getCheckoutFunction.data['transaction']['finalAmount'].toString())));
          GLogger.debug(checkoutId ?? 'No checkout ID!');
        }
        return getCheckoutFunction;
      } else {
        return null;
      }
    } catch (e) {
      state = AsyncError('Invalid Data', StackTrace.current);
      e.logException();
      return LocaleResponse(success: false, message: "orders.invalidOrder".translate(), data: null);
    }
  }

  Future<void> handlePayPressed(BuildContext context) async {
    ref.read(errorProvider.state).state = '';
    final CardInfo card = CardInfo(
        holder: nameController.text,
        cardNumber: cardNumberController.text,
        cvv: cvvController.text,
        expiryMonth: expDateController.text.split('/').first,
        expiryYear: '20' + expDateController.text.split('/').last);
    final success = await pay(card);
    if (success) {
      GLogger.debug('paid');
      EasyNavigator.popToFirstView(context);

      await GarageDialog.show(context: context, style: DialogStyle.success, message: 'payment.success'.translate());

      await EasyNavigator.openPage(context: context, page: const OrdersScreen());
    } else {
      GLogger.debug('rejected');

      ref.read(errorProvider.state).state = 'payment.failed';
    }
  }

  Future<bool> pay(CardInfo card) async {
    try {
      // if this is the second payment which means there is an incorrect payment before it, we have to reinitialize the checkout Id
      if (!isFirstPayment) {
        await prepareHyperpay();
      }
      HyperpayPlugin hyperpay = await HyperpayPlugin.setup(config: HyperpayConfig());
      final initOrder = ref.read(initOrderProvider);
      if (initOrder?.transaction == null) {
        return false;
      }
      hyperpay.initSession(checkoutId: checkoutId!, brand: getBrand(initOrder!.transaction!.paymentMethod));
      log(checkoutId.toString());
      await hyperpay.pay(card);
      Uri statusEndpointr = Uri(
        scheme: 'https',
        host: 'us-central1-garage-env-development.cloudfunctions.net',
        path: 'checkPaymentStatus',
      );
      final status = await post(statusEndpointr, headers: {
        'authorization': await FirebaseAuthServices.instance.currentUser?.getIdToken() ?? '',
      }, body: {
        'entityId': '8ac7a4ca81644159018167bb491714f7',
        'checkoutId': checkoutId!
      });
      log(status.body);
      isFirstPayment = false;
      final data = jsonDecode(status.body);
      if (data['success']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("exception");
      e.logException();
      return false;
    }
  }

  BrandType getBrand(PaymentMethod paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethod.mada:
        return BrandType.mada;
      case PaymentMethod.visa:
        return BrandType.visa;
      case PaymentMethod.masterCard:
        return BrandType.master;
      case PaymentMethod.applePay:
        return BrandType.applepay;
      default:
        throw Exception('Payment method not supported');
    }
  }
}
