import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class ContactConfirmationListTile extends StatelessWidget {
  const ContactConfirmationListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: LocaleKeys.general_settings_contact_confirmation,
        style: AppTextStyles.subTitleStyle,
      ),
    );
  }
}
