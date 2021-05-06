import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class LanguageSettingsListTile extends StatelessWidget {
  final String? languageTitle;
  final Locale? locale;
  const LanguageSettingsListTile({
    Key? key,
    this.languageTitle,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: context.locale == locale
          ? SvgPicture.asset(
              ImageConstant.COMMONS_CHECK_ICON,
            )
          : Text(""),
      tileColor: Colors.white,
      title: Text(
        languageTitle!,
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {
        context.setLocale(locale!);
      },
    );
  }
}
