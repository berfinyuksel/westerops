import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OnboardingText extends StatelessWidget {
  final String? text;
  const OnboardingText({
    Key? key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: LocaleText(
        text: text,
        style: AppTextStyles.bodyBoldTextStyle,
        alignment: TextAlign.center,
        maxLines: 3,
      
      ),
    );
  }
}
