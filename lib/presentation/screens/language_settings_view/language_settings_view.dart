import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/locale_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/language_settings_list_tile.dart';

class LanguageSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.language_settings_title,
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            LanguageSettingsListTile(
              languageTitle: "Türkçe",
              locale: LocaleConstant.TR_LOCALE,
            ),
            LanguageSettingsListTile(
              languageTitle: "English",
              locale: LocaleConstant.EN_LOCALE,
            ),
          ],
        ),
      ),
    );
  }
}
