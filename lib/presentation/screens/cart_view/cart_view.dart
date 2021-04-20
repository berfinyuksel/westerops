import '../past_order_detail_view/components/past_order_detail_basket_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_body_title.dart';
import '../past_order_detail_view/components/past_order_detail_payment_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_total_payment_list_tile.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: context.dynamicHeight(0.02),
          ),
          children: [
            PastOrderDetailBodyTitle(
              title: LocaleKeys.past_order_detail_body_title_1,
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            buildRestaurantListTile(context),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            PastOrderDetailBodyTitle(
              title: LocaleKeys.past_order_detail_body_title_3,
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            PastOrderDetailBasketListTile(
              title: "Anadolu Lezzetleri",
              price: 35,
              withDecimal: false,
              subTitle: "Pastırmalı Kuru Fasulye,\n1 porsiyon Kornişon Turşu",
            ),
            PastOrderDetailBasketListTile(
              title: "Vegan 4 Paket",
              price: 35,
              withDecimal: false,
              subTitle: "Brokoli Salatası, Vegan Sos\nSoya Soslu Fasulye",
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            PastOrderDetailBodyTitle(
              title: LocaleKeys.past_order_detail_body_title_4,
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            PastOrderDetailPaymentListTile(
              title: LocaleKeys.past_order_detail_payment_1,
              price: 70,
              lineTrough: false,
              withDecimal: false,
            ),
            PastOrderDetailPaymentListTile(
              title: LocaleKeys.past_order_detail_payment_2,
              price: 4.50,
              lineTrough: true,
              withDecimal: true,
            ),
            PastOrderDetailPaymentListTile(
              title: "${LocaleKeys.past_order_detail_payment_3.locale} (2)*",
              price: 0.50,
              lineTrough: false,
              withDecimal: true,
            ),
            PastOrderDetailTotalPaymentListTile(
              title: LocaleKeys.past_order_detail_payment_4,
              price: 70.50,
              withDecimal: true,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
          ],
        ),
        Spacer(),
        buildButton(context),
      ],
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.cart_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.PAYMENTS_VIEW);
        },
      ),
    );
  }

  ListTile buildRestaurantListTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_FORWARD_ICON,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: "Canım Büfe",
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {},
    );
  }
}
