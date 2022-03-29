import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../components/background_onboarding_svg.dart';
import '../components/onboarding_background_image.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgroundOnboarding(image:  ImageConstant.ONBOARDING_BACKGROUND),
        
           Padding(
            padding: EdgeInsets.symmetric(vertical: 70.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      ImageConstant.DONGU_LOGO,
                      fit: BoxFit.cover,
                      height: 135.h,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    buildText(context),
                  ],
                ),
                //   SizedBox(height:MediaQuery.of(context).size.height * 0.10),
                buildBottomText(context),
              ],
            ),
          ), 
         

        ],
      ),
    );
  }

  Container buildBottomText(BuildContext context) {
    return Container(
      height: 325.h,
      child: Column(
        children: [
          Spacer(flex: 13),
          Expanded(
            flex: 8,
            child: OnboardingHeadlineText(
              headlineText: LocaleKeys.onboardings_onboarding_text_headline,
              maxLines: 2,
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 8,
            child: OnboardingText(
              text: LocaleKeys.onboardings_text,
            ),
          ),
          Spacer(flex: 6),
        ],
      ),
    );
  }

  Container buildText(BuildContext context) {
    return Container(
      alignment: Alignment(0.5, -0.2),
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: AutoSizeText.rich(
        TextSpan(
          spellOut: false,
          style:
              AppTextStyles.headlineStyle.copyWith(color: AppColors.textColor),
          children: [
            TextSpan(
              text: LocaleKeys.onboardings_onboarding_text1.locale,
              style: GoogleFonts.montserrat(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: LocaleKeys.onboardings_onboarding_text2.locale,
              style: GoogleFonts.montserrat(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        maxLines: 5,
        maxFontSize: 25,
      ),
    );
  }
}
