import 'package:flutter/material.dart';
import 'package:garage_client/models/transaction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/widgets/price_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionWidget extends ConsumerStatefulWidget {
  const TransactionWidget({
    Key? key,
    required Transaction transaction,
    required this.getTransactionTime,
  })  : _transaction = transaction,
        super(key: key);

  final Transaction _transaction;
  final String Function(Transaction) getTransactionTime;

  @override
  ConsumerState<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends ConsumerState<TransactionWidget> {
  Color get _color {
    switch (widget._transaction.type) {
      case TransactionType.withdrawal:
      case TransactionType.sendGift:
        return ColorsConst.negativeRed;
      default:
        return ColorsConst.positiveGreen;
    }
  }

  IconData get _icon {
    switch (widget._transaction.type) {
      case TransactionType.withdrawal:
      case TransactionType.sendGift:
        return GarageIcons.Arrow___Down_Square;
      default:
        return GarageIcons.Arrow___Up_Square;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.7.w),
        width: 310.w,
        height: 63.h,
        child: Row(
          children: [
            Container(
              width: 30.26.w,
              height: 30.62.w,
              decoration: BoxDecoration(color: _color.withOpacity(0.05), borderRadius: BorderRadius.circular(6.w)),
              child: Icon(
                _icon,
                size: 25.sp,
                color: _color,
              ),
            ),
            SpacingConst.hSpacing8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'transaction_type.${widget._transaction.type.name}'.translate(),
                  style: context.textThemes.bodyMedium,
                ),
                Text(widget.getTransactionTime(widget._transaction),
                    style: context.textThemes.displaySmall?.copyWith(color: ColorsConst.lightGrey)),
              ],
            ),
            const Spacer(),
            PriceText(
              fontSize: 17.sp,
              price: widget._transaction.finalAmount ?? 0.0,
              currency: Currency.sar,
              currencyColor: ColorsConst.dartGrey,
            ),
            SizedBox(
              width: 15.w,
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.sp),
            boxShadow: [
              BoxShadow(color: ColorsConst.black.withOpacity(0.03), blurRadius: 4),
            ],
            color: ColorsConst.white));
  }
}
