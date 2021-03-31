import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'delivery_available_time.dart';

class DeliveryAvailableTimeListTile extends StatelessWidget {
  const DeliveryAvailableTimeListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: DeliveryAvailableTime(
        time: "18:00-21:00",
        height: context.dynamicHeight(0.05),
        width: context.dynamicWidht(0.35),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: LocaleKeys.payment_delivery_delivery_time,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      onTap: () {},
    );
  }
}
