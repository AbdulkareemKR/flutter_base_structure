import 'package:flutter/material.dart';
import 'package:garage_core/constants/constants.dart';
import 'package:garage_core/enums/currency.dart';
import 'package:garage_core/services/double_services.dart';
import 'package:garage_core/services/wallet_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const amountSmallerFraction = 4;

class PriceText extends StatelessWidget {
  final num price;
  final Currency? currency;
  final Color priceColor;
  final Color currencyColor;
  final double fontSize;
  final FontWeight weight;
  final bool isPercent;
  final String? fontFamily;

  /// The amount to suntract from the fontSize for the fractional part
  const PriceText(
      {Key? key,
      required this.price,
      this.weight = FontWeight.normal,
      this.currency,
      this.priceColor = Colors.black,
      this.currencyColor = lightGrey,
      this.fontFamily,
      this.fontSize = 13,
      this.isPercent = false})
      : // One of them should be selected only
        assert((isPercent == false && currency != null) || (isPercent == true && currency == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: price.toInt().toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: priceColor, fontFamily: fontFamily, fontSize: fontSize, fontWeight: weight)),
            TextSpan(
                text: DoubleServices.getFractionString(price),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: priceColor,
                    fontFamily: fontFamily,
                    fontSize: (fontSize - amountSmallerFraction),
                    fontWeight: weight)),
          ]),
        ),
        SizedBox(
          width: 2.w,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: isPercent ? '%' : getCurrencyString(currency!),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: currencyColor,
                  fontFamily: fontFamily,
                  fontSize: (fontSize - amountSmallerFraction),
                  fontWeight: weight),
            )
          ]),
        ),
      ],
    );
  }
}
