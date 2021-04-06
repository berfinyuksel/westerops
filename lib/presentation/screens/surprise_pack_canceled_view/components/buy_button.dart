import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.04),
      width: context.dynamicWidht(0.28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.greenColor,
        border: Border.all(
          width: 2.0,
          color: AppColors.greenColor,
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: LocaleText(
          text: LocaleKeys.surprise_pack_canceled_button_buy,
          style: AppTextStyles.bodyTitleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
