import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingThirdView extends StatelessWidget {
  final Widget? carouselPoints;

  const OnboardingThirdView({Key? key, this.carouselPoints}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SvgPicture.asset(
            ImageConstant.ONBOARD_THIRD_BOTTOM_BACKGROUND,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                SvgPicture.asset(
                  ImageConstant.DONGU_LOGO,
                  fit: BoxFit.cover,
                  height: 70.h,
                ),
                SvgPicture.asset(
                  ImageConstant.ONBOARD_THIRD_IMAGE,
                  fit: BoxFit.fitHeight,
                  height: 330.h,
                ),
                SizedBox(height: 160.h),
                OnboardingHeadlineText(
                  headlineText: LocaleKeys.onboardings_third_text_headline,
                  maxLines: 3,
                ),
                SizedBox(height: 10.h),
                OnboardingText(
                  text: LocaleKeys.onboardings_third_text_third,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
