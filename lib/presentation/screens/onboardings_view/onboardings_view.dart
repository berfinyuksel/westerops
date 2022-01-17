import '../../../data/shared/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import 'onboarding_first_view/onboarding_first_view.dart';
import 'onboarding_forth_view/onboarding_forth_view.dart';
import 'onboarding_second_view/onboarding_second_view.dart';
import 'onboarding_third/onboarding_third_view.dart';
import 'onboarding_view/onboarding_view.dart';

class OnboardingsView extends StatefulWidget {
  @override
  _OnboardingsViewState createState() => _OnboardingsViewState();
}

class _OnboardingsViewState extends State<OnboardingsView> {
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  Row buildRowForth(BuildContext context) {
    return Row(
      children: [
        Spacer(flex: 139),
        Expanded(flex: 81, child: buildCarouselPoints(context)),
        Spacer(flex: 20),
        Expanded(
          flex: 140,
          child: CustomButton(
            onPressed: () {
              SharedPrefs.onboardingShown();
              Navigator.pushReplacementNamed(
                  context, RouteConstant.NOTIFICATION_VIEW);
            },
            title: LocaleKeys.onboardings_forth_button,
            textColor: Colors.white,
            color: AppColors.greenColor,
            borderColor: Colors.transparent,
          ),
        ),
        Spacer(flex: 28),
      ],
    );
  }

  Row buildRowFromFirstToThird(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(flex: 28),
        Expanded(
          flex: 85,
          child: GestureDetector(
            onTap: () {
              setState(() {
                pageController.animateToPage(4,
                    duration: Duration(milliseconds: 1000), curve: Curves.ease);
              });
            },
            child: LocaleText(
              text: LocaleKeys.onboardings_skip,
              style: AppTextStyles.bodyTextStyle,
              maxLines: 1,
            ),
          ),
        ),
        Spacer(flex: 20),
        Expanded(
          flex: 81,
          child: buildCarouselPoints(context),
        ),
        Spacer(flex: 20),
        Expanded(
          flex: 140,
          child: CustomButton(
            onPressed: () {
              pageController.nextPage(
                  duration: Duration(milliseconds: 1000), curve: Curves.ease);
            },
            title: LocaleKeys.onboardings_button,
            textColor: Colors.white,
            color: AppColors.greenColor,
            borderColor: Colors.transparent,
          ),
        ),
        Spacer(flex: 28),
      ],
    );
  }

  SmoothPageIndicator buildCarouselPoints(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController, // PageController
      count: 5,
      effect: ExpandingDotsEffect(
        dotWidth: context.dynamicHeight(0.01),
        dotHeight: context.dynamicHeight(0.01),
        spacing: 4.0,
        dotColor: AppColors.greenColor.withOpacity(.3),
        activeDotColor: AppColors.greenColor,
      ),
    );
  }

  Container buildContainerCarousel(BuildContext context, List onboardings) {
    return Container(
      height: context.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: PageView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return onboardings[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> onboardings = [
      OnboardingView(),
      OnboardingFirstView(),
      OnboardingSecondView(),
      OnboardingThirdView(),
      OnboardingForthView(),
    ];
    return Stack(
      children: [
        buildContainerCarousel(context, onboardings),
        Positioned(
          left: 0,
          right: 0,
          bottom: context.dynamicHeight(0.03),
          child: Container(
            child: pageIndex != 4
                ? buildRowFromFirstToThird(context)
                : buildRowForth(context),
          ),
        )
      ],
    );
  }
}
