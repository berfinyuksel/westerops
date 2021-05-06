import '../../text/locale_text.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../utils/extensions/context_extension.dart';

class DrawerBodyTitle extends StatelessWidget {
  final String? text;
  const DrawerBodyTitle({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: text,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }
}
