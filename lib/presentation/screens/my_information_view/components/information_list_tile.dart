import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';


class InformationListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const InformationListTile({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: Text(
        subtitle!,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      onTap: () {},
    );
  }
}
