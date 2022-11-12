import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_core/models/coupon.dart';

List<Coupon> getCouponWithUid(String userID) {
  // TODO : implement firebase query to get the copons that have this user is

  // For testing I will return these data
  return [
    Coupon.fromMap({
      'id': '123',
      'code': 'قراج',
      'expirationDate': Timestamp.fromDate(DateTime.now().add(Duration(days: 100))),
      'discountPercentage': 30.0,
      'isValid': true,
      'issuerId': 'issuerId',
      'campaign': 'campaign',
      'totalUsage': 2,
      'usageLimit': 10,
      'currency': 'sar',
      'couponUsage': {
        'nawafUser': 2,
      },
    }),
    Coupon.fromMap({
      'id': '123',
      'code': 'حياك',
      'expirationDate': Timestamp.fromDate(DateTime.now().add(Duration(days: 100))),
      'discountAmount': 50.0,
      'isValid': true,
      'issuerId': 'issuerId',
      'campaign': 'campaign',
      'totalUsage': 2,
      'currency': 'sar',
      'usageLimit': 10,
      'couponUsage': {
        'nawafUser': 2,
      },
    }),
  ];
}

double applyCoupon(Coupon coupon, double totalPrice) {
  final newTotalPrice;
  if (coupon.isFixedAmount) {
    if (totalPrice - coupon.discountAmount! > 0) {
      // We don't want the total price after discount to be negative
      newTotalPrice = totalPrice - coupon.discountAmount!;
    } else {
      // If it will be negative then return 0
      newTotalPrice = 0.0;
    }
  } else {
    // In case of discount percentage
    newTotalPrice = totalPrice - totalPrice * (coupon.discountPercentage! / 100);
  }
  return newTotalPrice;
}
