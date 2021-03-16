import 'package:flutter/material.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_first_view/onboarding_first_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_forth_view/onboarding_forth_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_second_view/onboarding_second_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_third/onboarding_third_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_view/onboarding_view.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import '../../../utils/extensions/context_extension.dart';

class OnboardingsView extends StatefulWidget {
  @override
  _OnboardingsViewState createState() => _OnboardingsViewState();
}

class _OnboardingsViewState extends State<OnboardingsView> {
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;
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
            child: pageIndex != 4 ? buildRowFromFirstToThird(context) : buildRowForth(context),
          ),
        )
      ],
    );
  }

  Row buildRowForth(BuildContext context) {
    return Row(
      children: [
        Spacer(flex: 28),
        Expanded(flex: 81, child: buildCenterCarouselPoints(context)),
        Spacer(flex: 70),
        Expanded(
          flex: 212,
          child: CustomButton(
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
      children: [
        Spacer(flex: 28),
        Expanded(
          flex: 91,
          child: GestureDetector(
            onTap: () {
              setState(() {
                pageController.animateToPage(4, duration: Duration(milliseconds: 1000), curve: Curves.ease);
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
        Expanded(flex: 81, child: buildCenterCarouselPoints(context)),
        Spacer(flex: 20),
        Expanded(
          flex: 140,
          child: CustomButton(
            onPressed: () {
              pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.ease);
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

  Container buildContainerCarousel(BuildContext context, List onboardings) {
    return Container(
      height: context.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
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

  Center buildCenterCarouselPoints(BuildContext context) {
    return Center(
      child: Container(
        height: context.height * 0.01,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return pageIndex == index
                ? Container(
                    height: context.dynamicHeight(0.01),
                    width: context.dynamicHeight(0.03),
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.greenColor,
                    ),
                  )
                : Container(
                    height: context.dynamicHeight(0.01),
                    width: context.dynamicHeight(0.01),
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greenColor.withOpacity(.3),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
