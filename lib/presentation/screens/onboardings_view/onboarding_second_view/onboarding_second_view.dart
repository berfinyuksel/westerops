import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/onboarding_background_image.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingSecondView extends StatelessWidget {
  final Widget? carouselPoints;

  const OnboardingSecondView({Key? key, this.carouselPoints}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingBackgroundImage(
              image: ImageConstant.ONBOARDING_SECOND_BACKGROUND,
            ),
          ),
          Positioned(
            bottom: 70.h,
            left: 0,
            right: 0,
            child: buildBottomText(context),
          )
        ],
      ),
    );
  }

  Container buildBottomText(BuildContext context) {
    return Container(
      height: 326.h,
      child: Column(
        children: [
          Spacer(flex: 13),
          Expanded(
            flex: 8,
            child: OnboardingHeadlineText(
              headlineText: LocaleKeys.onboardings_second_text_headline,
              maxLines: 2,
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 8,
            child: OnboardingText(
              text: LocaleKeys.onboardings_second_text_second,
            ),
          ),
          Spacer(flex: 6),
        ],
      ),
    );
  }
}
