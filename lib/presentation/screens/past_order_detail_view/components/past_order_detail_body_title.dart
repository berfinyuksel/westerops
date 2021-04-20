import '../../../widgets/text/locale_text.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../utils/extensions/context_extension.dart';

class PastOrderDetailBodyTitle extends StatelessWidget {
  final String? title;
  const PastOrderDetailBodyTitle({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: title!,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }
}
