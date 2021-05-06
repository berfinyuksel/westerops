import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

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
