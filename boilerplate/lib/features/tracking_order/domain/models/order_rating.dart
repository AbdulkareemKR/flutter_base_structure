import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_rating.freezed.dart';

@freezed
class OrderRatingInfo with _$OrderRatingInfo {
  const factory OrderRatingInfo({
    String? orderId,
    int? rating,
    String? comment,
  }) = _OrderRatingInfo;
}
