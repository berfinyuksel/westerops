import 'package:dongu_mobile/presentation/screens/onboardings_view/components/onboarding_background_image.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/components/onboarding_bottom_row.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/components/onboarding_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OnboardingForthView extends StatelessWidget {
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
            image: ImageConstant.ONBOARDING_FORTH_BACKGROUND,
          ),
        ),
        OnboardingText(
          text: LocaleKeys.onboardings_text,
        ),
        OnboardingBottomRow(),
      ],
    );
  }
}
