import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingFirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: context.dynamicHeight(0.14)),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              ImageConstant.ONBOARDING_FIRST_BACKGROUND,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          alignment: Alignment(0, 0.75),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
          child: LocaleText(
            text: LocaleKeys.onboarding_first_text,
            style: AppTextStyles.bodyBoldTextStyle,
            alignment: TextAlign.center,
            maxLines: 3,
          ),
        ),
        Container(
          alignment: Alignment(0, 0.9),
          child: Row(
            children: [
              Spacer(flex: 28),
              Expanded(
                flex: 91,
                child: LocaleText(
                  text: LocaleKeys.onboarding_first_skip,
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
                  title: LocaleKeys.onboarding_first_button,
                  textColor: Colors.white,
                  color: AppColors.greenColor,
                  borderColor: Colors.transparent,
                ),
              ),
              Spacer(flex: 28),
            ],
          ),
        ),
      ],
    );
  }
}
