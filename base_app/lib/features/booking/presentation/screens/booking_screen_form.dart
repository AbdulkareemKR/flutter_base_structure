import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/colors_const.dart';
import 'package:garage_client/features/booking/presentation/screens/booking_screen.dart';
import 'package:garage_client/features/booking/presentation/screens/review_booking_screen.dart';
import 'package:garage_client/features/payment/presentation/controllers/payment_state_notifier.dart';
import 'package:garage_client/features/payment/presentation/screens/payment_screen.dart';
import 'package:garage_core/models/service.dart';

final bookingPageControllerProvider = Provider.autoDispose<PageController>((ref) {
  return PageController();
});

class BookingScreenFrom extends ConsumerStatefulWidget {
  const BookingScreenFrom({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  ConsumerState<BookingScreenFrom> createState() => _BookingScreenFromState();
}

class _BookingScreenFromState extends ConsumerState<BookingScreenFrom> {
  @override
  void initState() {
    /// Making suer that it is a new [PageController]
    ref.refresh(bookingPageControllerProvider);

    /// Making sure that the payment provider is refreshed
    ///
    ref.refresh(paymentStateProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConst.white,
      height: 740.h,
      width: 1.sw,
      child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.watch(bookingPageControllerProvider),
          children: [
            BookingScreen(
              service: widget.service,
            ),
            ReviewBookingScreen(
              service: widget.service,
            ),
            const PaymentScreen()
          ]),
    );
  }
}
