import 'package:dongu_mobile/presentation/screens/language_settings_view/components/language_settings_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/locale_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';

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
