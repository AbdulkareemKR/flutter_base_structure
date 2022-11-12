import 'package:flutter/material.dart';
import 'package:garage_client/global_services/enums/currency.dart';
import 'package:garage_client/global_services/widgets/price_text.dart';
import 'package:sizer/sizer.dart';

class PriceTextField extends StatelessWidget {
  const PriceTextField({
    Key? key,
    required this.onTap,
    required this.onChange,
    required this.controller,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  final void Function() onTap;
  final void Function(String?) onChange;
  final TextEditingController controller;
  final double amount;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(children: [
          Text(
            // TODO : user translateion
            'المبلغ',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          PriceText(
            weight: FontWeight.bold,
            fontSize: 12.sp,
            currencyColor: Colors.black,
            currency: currency,
            price: amount,
          ),
        ]),
        TextField(
          enableInteractiveSelection: false,
          controller: controller,
          onTap: onTap,
          onChanged: onChange,
          style: const TextStyle(color: Colors.transparent),
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
          showCursor: false,
          decoration: const InputDecoration(border: InputBorder.none),
        )
      ],
    );
  }
}
