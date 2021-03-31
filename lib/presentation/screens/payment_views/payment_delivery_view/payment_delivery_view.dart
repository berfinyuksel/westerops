import 'package:dongu_mobile/presentation/screens/payment_views/payment_delivery_view/components/delivery_custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'components/delivery_available_time_list_tile.dart';
import '../../../widgets/warning_container/warning_container.dart';

class PaymentDeliveryView extends StatefulWidget {
  final bool? isGetIt;

  const PaymentDeliveryView({Key? key, this.isGetIt}) : super(key: key);

  @override
  _PaymentDeliveryViewState createState() => _PaymentDeliveryViewState();
}

class _PaymentDeliveryViewState extends State<PaymentDeliveryView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
      ),
      child: ListView(
        shrinkWrap: true,
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
                  visible: widget.isGetIt!,
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
                      WarningContainer(
                        text: "Ödemenizi size iletmiş olduğumuz\nsipariş numarasını restorana\ngöstererek yapınız.",
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                    ],
                  ),
                ),
                buildAvailableDeliveryTimes(context),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                WarningContainer(
                  text:
                      "Belirtilen saat içerisinde \nrestorandan paketinizi 1 saat içinde \nalmadığınız durumda siparişiniz \niptal edilip tekrar satışa sunulacaktır.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Visibility buildAvailableDeliveryTimes(BuildContext context) {
    return Visibility(
      visible: !widget.isGetIt!,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: context.dynamicWidht(0.046),
        mainAxisSpacing: context.dynamicHeight(0.02),
        childAspectRatio: context.dynamicWidht(0.4) / context.dynamicHeight(0.05),
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        children: buildDeliveryButtons(context),
      ),
    );
  }

  buildDeliveryButtons(BuildContext context) {
    List<Widget> buttons = [];
    int hourLeft = 18;
    int hourRight = 18;

    for (int i = 0; i < 6; i++) {
      buttons.add(
        DeliveryCustomButton(
          width: context.dynamicWidht(0.4),
          title: "$hourLeft:${i % 2 == 1 ? "30" : "00"} - $hourRight:${i % 2 == 1 ? "00" : "30"}",
          color: selectedIndex == i ? AppColors.greenColor.withOpacity(0.4) : Color(0xFFE4E4E4).withOpacity(0.7),
          onPressed: () {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      hourLeft = hourLeft + (i % 2 == 1 ? 1 : 0);
      hourRight = hourRight + (i % 2 == 0 ? 1 : 0);
    }

    return buttons;
  }
}
