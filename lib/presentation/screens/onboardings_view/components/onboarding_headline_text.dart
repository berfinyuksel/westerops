import '../../../widgets/text/locale_text.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../utils/extensions/context_extension.dart';

import 'package:flutter/material.dart';

class OnboardingHeadlineText extends StatelessWidget {
  final String? headlineText;
  final int? maxLines;
  const OnboardingHeadlineText({
    Key? key,
    this.headlineText,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: LocaleText(
        text: headlineText,
        style: AppTextStyles.headlineStyle,
        alignment: TextAlign.center,
        maxLines: maxLines,
      ),
    );
  }
}
