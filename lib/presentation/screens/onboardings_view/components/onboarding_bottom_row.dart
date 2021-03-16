import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingBottomRow extends StatelessWidget {
  const OnboardingBottomRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.9),
      child: Row(
        children: [
          Spacer(flex: 28),
          Expanded(
            flex: 91,
            child: LocaleText(
              text: LocaleKeys.onboardings_skip,
              style: AppTextStyles.bodyTextStyle,
            ),
          ),
          Spacer(flex: 28),
          Expanded(
            //this will be swiper
            flex: 81,
            child: Text(
              "Swiper",
              style: AppTextStyles.bodyTextStyle,
            ),
          ),
          Spacer(flex: 28),
          Expanded(
            flex: 140,
            child: CustomButton(
              title: LocaleKeys.onboardings_button,
              textColor: Colors.white,
              color: AppColors.greenColor,
              borderColor: Colors.transparent,
            ),
          ),
          Spacer(flex: 28),
        ],
      ),
    );
  }
}
