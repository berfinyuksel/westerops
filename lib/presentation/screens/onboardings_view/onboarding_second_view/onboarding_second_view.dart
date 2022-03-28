import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingSecondView extends StatelessWidget {
  final Widget? carouselPoints;

  const OnboardingSecondView({Key? key, this.carouselPoints}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              // bottom: 0,
              // top: 230,
              child: SvgPicture.asset(
                ImageConstant.ONBOARD_SECOND_BOTTOM_BACKGROUND,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  SvgPicture.asset(
                    ImageConstant.DONGU_LOGO,
                    fit: BoxFit.fitHeight,
                    height: 70.h,
                  ),
                  SvgPicture.asset(
                    ImageConstant.ONBOARD_SECOND_IMAGE,
                    fit: BoxFit.fitHeight,
                    height: 330.h,
                  ),
                  SizedBox(height: 150.h),
                  OnboardingHeadlineText(
                    headlineText: LocaleKeys.onboardings_second_text_headline,
                    maxLines: 2,
                  ),
                  SizedBox(height: 10.h),
                  OnboardingText(
                    text: LocaleKeys.onboardings_second_text_second,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
