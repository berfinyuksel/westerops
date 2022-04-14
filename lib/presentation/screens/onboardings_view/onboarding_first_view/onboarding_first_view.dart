import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/background_onboarding_svg.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingFirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
           BackgroundOnboarding(image:  ImageConstant.ONBOARD_FIRST_BOTTOM_BACKGROUND),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                SvgPicture.asset(
                  ImageConstant.DONGU_LOGO,
                  fit: BoxFit.fitHeight,
                  height: 70.h,
                ),
                SvgPicture.asset(
                  ImageConstant.ONBOARD_FIRST_IMAGE,
                  fit: BoxFit.fitHeight,
                  height: 330.h,
                ),
                SizedBox(height: 130.h),
                OnboardingHeadlineText(
                  headlineText: LocaleKeys.onboardings_first_text_headline,
                ),
                SizedBox(height: 10.h),
                OnboardingText(
                  text: LocaleKeys.onboardings_first_text_first,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
