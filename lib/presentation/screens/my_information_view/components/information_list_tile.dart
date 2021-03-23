import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';


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
