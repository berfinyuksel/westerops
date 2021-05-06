import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubits/payment_cubit/payment_cubit.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class OrderSummaryContainer extends StatelessWidget {
  const OrderSummaryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final PaymentState state = context.watch<PaymentCubit>().state;
      return Container(
        padding: EdgeInsets.only(left: context.dynamicWidht(0.07)),
        width: double.infinity,
        height: context.dynamicHeight(0.21),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 5),
            LocaleText(
              text: "23 Mart 2021 - Salı - 20:08",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            Spacer(flex: 2),
            LocaleText(
              text:
                  "18:00-21:00${state.isGetIt! ? LocaleKeys.order_received_take_from_restaurant.locale : " Kurye ile adresinize teslim edilecektir."}",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 2),
            LocaleText(
              text: "${state.isGetIt! ? "Gel-Al Paket" : "Motorlu Kurye"} - ${state.isOnline! ? "Online Ödeme (Kredi Kartı)" : "Kapıda Ödeme"}",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 5),
            LocaleText(
              text: "Sepetindeki ürün adedi: 2",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 3),
            LocaleText(
              text: "${LocaleKeys.order_received_item_number.locale} 70,50 TL",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 3),
            LocaleText(
              text: "${LocaleKeys.order_received_total_amount.locale} 70,50 TL",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            Spacer(flex: 5),
          ],
        ),
      );
    });
  }
}
