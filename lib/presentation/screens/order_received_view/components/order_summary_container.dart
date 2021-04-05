import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderSummaryContainer extends StatelessWidget {
  const OrderSummaryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            text: "18:00-21:00${LocaleKeys.order_received_take_from_restaurant}",
            style: AppTextStyles.bodyTextStyle,
          ),
          Spacer(flex: 2),
          LocaleText(
            text: "Gel-Al Paket - Online Ödeme (Kredi Kartı)",
            style: AppTextStyles.bodyTextStyle,
          ),
          Spacer(flex: 5),
          LocaleText(
            text: "Sepetindeki ürün adedi: 2",
            style: AppTextStyles.bodyTextStyle,
          ),
          Spacer(flex: 3),
          LocaleText(
            text: "${LocaleKeys.order_received_item_number} 70,50 TL",
            style: AppTextStyles.bodyTextStyle,
          ),
          Spacer(flex: 3),
          LocaleText(
            text: "${LocaleKeys.order_received_total_amount} 70,50 TL",
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
