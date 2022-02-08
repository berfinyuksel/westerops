import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/onboarding_background_image.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingFirstView extends StatelessWidget {
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
              image: ImageConstant.ONBOARDING_FIRST_BACKGROUND,
            ),
          ),
          Positioned(
            bottom: context.dynamicHeight(0.083),
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
      height: 323.h,
      child: Column(
        children: [
          Spacer(flex: 13),
          Expanded(
            flex: 5,
            child: OnboardingHeadlineText(
              headlineText: LocaleKeys.onboardings_first_text_headline,
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: OnboardingText(
              text: LocaleKeys.onboardings_first_text_first,
            ),
          ),
          Spacer(flex: 6),
        ],
      ),
    );
  }
}
