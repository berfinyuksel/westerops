import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
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
              ImageConstant.ONBOARDING_BACKGROUND,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          alignment: Alignment(0.5, -0.2),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
          child: AutoSizeText.rich(
            TextSpan(
              style: AppTextStyles.headlineStyle.copyWith(color: AppColors.textColor),
              children: [
                TextSpan(
                  text: LocaleKeys.onboarding_text1.locale,
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: LocaleKeys.onboarding_text2.locale,
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}
