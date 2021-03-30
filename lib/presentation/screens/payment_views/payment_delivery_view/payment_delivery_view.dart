import 'package:dongu_mobile/presentation/screens/payment_views/payment_delivery_view/components/delivery_custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'components/delivery_available_time_list_tile.dart';
import 'components/delivery_warning_container.dart';

class PaymentDeliveryView extends StatelessWidget {
  final bool? isGetIt;

  const PaymentDeliveryView({Key? key, this.isGetIt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeliveryAvailableTimeListTile(),
          SizedBox(
            height: context.dynamicHeight(0.04),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocaleText(
                  text: "Bugün - 23 Mart 2021",
                  style: AppTextStyles.bodyTitleStyle,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.01),
                ),
                Visibility(
                  visible: isGetIt!,
                  child: Column(
                    children: [
                      DeliveryCustomButton(
                        width: double.infinity,
                        title: "18:00 - 21:00",
                        color: AppColors.greenColor.withOpacity(0.4),
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      DeliveryWarningContainer(
                        text: "Ödemenizi size iletmiş olduğumuz\nsipariş numarasını restorana\ngöstererek yapınız.",
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                    ],
                  ),
                ),
                buildAvailableDeliveryTimes(context),
                DeliveryWarningContainer(
                  text:
                      "Belirtilen saat içerisinde \nrestorandan paketinizi 1 saat içinde \nalmadığınız durumda siparişiniz \niptal edilip tekrar satışa sunulacaktır.",
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.dynamicHeight(0.04),
          ),
          buildButton(context),
        ],
      ),
    );
  }

  Visibility buildAvailableDeliveryTimes(BuildContext context) {
    return Visibility(
      visible: !isGetIt!,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: context.dynamicWidht(0.046),
        mainAxisSpacing: context.dynamicHeight(0.02),
        childAspectRatio: context.dynamicWidht(0.4) / context.dynamicHeight(0.05),
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "18:00 - 18:30",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "18:30 - 19:00",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "19:00 - 19:30",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "19:30 - 20:00",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "20:00 - 20:30",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
          DeliveryCustomButton(
            width: context.dynamicWidht(0.4),
            title: "20:30 - 21:00",
            color: AppColors.greenColor.withOpacity(0.4),
          ),
        ],
      ),
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
        title: LocaleKeys.payment_button_go_on,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }
}
