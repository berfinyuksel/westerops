import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class AboutAppListTile extends StatelessWidget {
  final String? text;
  final String? trailingText;
  final VoidCallback? onTap;
  const AboutAppListTile({
    Key? key,
    this.text,
    this.trailingText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LocaleText(
            text: trailingText == null ? "" : trailingText,
            style: AppTextStyles.subTitleStyle,
          ),
          SizedBox(width: context.dynamicWidht(0.06)),
          SvgPicture.asset(
            ImageConstant.COMMONS_FORWARD_ICON,
          ),
        ],
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: text,
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: onTap,
    );
  }
}
