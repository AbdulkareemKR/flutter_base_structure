import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_client/constants/constants.dart';
import 'package:garage_client/constants/spacing_const.dart';
import 'package:garage_client/features/wallet/presentation/controllers/wallet_controller.dart';
import 'package:garage_client/features/wallet/presentation/widgets/transaction_widget.dart';
import 'package:garage_client/global_providers/wallet_provider.dart';
import 'package:garage_client/localization/extensions.dart';
import 'package:garage_client/utils/general_extensions.dart';
import 'package:garage_client/utils/theme/extensions.dart';
import 'package:garage_client/global_services/models/transaction.dart';
import 'package:garage_client/global_services/models/user_car.dart';
import 'package:garage_client/global_services/widgets/bottom_sheet/utils/sheet.dart';
import 'package:garage_client/global_services/widgets/conditionary_widget/conditionary_widget.dart';
import 'package:garage_client/global_services/widgets/images/svg_image.dart';
import 'package:garage_client/global_services/widgets/price_text.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({Key? key, this.userCar}) : super(key: key);

  final UserCar? userCar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletProvider);
    final controller = ref.watch(walletControllerProvider);

    return state.build((wallet) {
      return Sheet(title: 'wallet.title'.translate(), scroll: false, children: [
        Container(
            padding: EdgeInsets.only(top: 11.h),
            width: 305.w,
            height: 99.h,
            child: Column(
              children: [
                Text(
                  'payment.price'.translate(),
                  style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.cosmicCobalt.shade300),
                ),
                SizedBox(
                  height: 5.h,
                ),
                PriceText(
                  fontSize: 25.sp,
                  weight: FontWeight.w500,
                  price: wallet?.amount ?? 0.0,
                  currency: Currency.sar,
                  priceColor: ColorsConst.cosmicCobalt,
                  currencyColor: ColorsConst.cosmicCobalt,
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.sp),
                boxShadow: [
                  BoxShadow(color: ColorsConst.black.withOpacity(0.05), blurRadius: 10),
                ],
                color: ColorsConst.white)),
        SpacingConst.vSpacing16,
        ConditionaryWidget(
          condition: wallet?.transactions.isNotEmpty ?? false,
          trueWidget: Column(
            children: [
              Text(
                'wallet.transactions'.translate(),
                style: context.textThemes.titleMedium,
              ),
              SpacingConst.vSpacing16,
              SizedBox(
                height: 50.sh,
                child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(wallet?.transactions.length ?? 0, (index) {
                    final sortedWallet = controller.sortTransaction(wallet);
                    return ConditionaryWidget(
                      condition: sortedWallet!.transactions[index].isMiddleTransaction != true,
                      trueWidget: TransactionWidget(
                        transaction: sortedWallet.transactions[index],
                        getTransactionTime: controller.getTransactionTime,
                      ),
                    );
                  })),
                ),
              ),
            ],
          ),
          falseWidget: Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 55.h,
              ),
              const SvgImage(
                imagePath: AssetsConst.noTransactions,
                scale: 1.2,
              ),
              Text(
                'wallet.noTransaction'.translate(),
                style: context.textThemes.titleMedium?.copyWith(color: ColorsConst.cosmicCobalt),
              ),
              Text(
                'wallet.transactionShowHere'.translate(),
                style: context.textThemes.bodyMedium?.regular.copyWith(color: ColorsConst.blackCoral),
              ),
            ],
          )),
        )
      ]);
    });
  }
}
