import 'package:flutter/material.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../components/onboarding_background_image.dart';
import '../components/onboarding_headline_text.dart';
import '../components/onboarding_text.dart';

class OnboardingThirdView extends StatelessWidget {
  final Widget? carouselPoints;

  const OnboardingThirdView({Key? key, this.carouselPoints}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: OnboardingBackgroundImage(
            image: ImageConstant.ONBOARDING_THIRD_BACKGROUND,
          ),
        ),
        Positioned(
          bottom: context.dynamicHeight(0.08),
          left: 0,
          right: 0,
          child: buildBottomText(context),
        )
      ],
    );
  }

  Container buildBottomText(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.3),
      child: Column(
        children: [
          Spacer(flex: 3),
          Expanded(
            flex: 5,
            child: OnboardingHeadlineText(
              headlineText: LocaleKeys.onboardings_third_text_headline,
              maxLines: 3,
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 4,
            child: OnboardingText(
              text: LocaleKeys.onboardings_text,
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
