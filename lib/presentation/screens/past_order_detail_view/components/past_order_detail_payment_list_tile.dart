import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PastOrderDetailPaymentListTile extends StatelessWidget {
  final String? title;
  final double? price;
  final bool oldPrice;
  final bool? lineTrough;
  final bool? withDecimal;

  const PastOrderDetailPaymentListTile({
    Key? key,
    this.title,
    this.price,
    this.oldPrice = false,
    @required this.lineTrough,
    this.withDecimal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Container(
        alignment: Alignment.centerRight,
        width: context.dynamicWidht(0.3),
        height: context.dynamicHeight(0.04),
        child: Row(
          children: [
           oldPrice ? Builder(
                  builder: (context) {
                final state = context.watch<SumOldPriceOrderCubit>().state;
                    return Text(
                        '${withDecimal! ? state.toDouble().toStringAsFixed(2) : state.toDouble().toStringAsFixed(0)} TL',
                        style: AppTextStyles.bodyBoldTextStyle.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.unSelectedpackageDeliveryColor),
                      );
                  }
                ) : Spacer()
                ,
            SizedBox(width: context.dynamicWidht(0.02)),
            Container(
              alignment: Alignment.center,
              width: context.dynamicWidht(0.15),
              height: context.dynamicHeight(0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: AppColors.scaffoldBackgroundColor,
              ),
              child: Text(
                '${withDecimal! ? price!.toStringAsFixed(2) : price!.toStringAsFixed(0)} TL',
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(color: AppColors.greenColor),
              ),
            ),
          ],
        ),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title!,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }
}
