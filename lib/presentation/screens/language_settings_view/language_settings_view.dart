import 'package:flutter/material.dart';

import '../../../utils/constants/locale_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/language_settings_list_tile.dart';

class LanguageSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.language_settings_title,
      body: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.02)),
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
