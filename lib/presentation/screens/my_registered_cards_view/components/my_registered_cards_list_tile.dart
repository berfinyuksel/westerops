import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class MyRegisteredCardsListTile extends StatefulWidget {
  final String? title;
  final String? subtitleBold;
  final VoidCallback? onTap;

  const MyRegisteredCardsListTile({
    Key? key,
    this.title,
    this.subtitleBold,
    this.onTap,
  }) : super(key: key);

  @override
  State<MyRegisteredCardsListTile> createState() =>
      _MyRegisteredCardsListTileState();
}

class _MyRegisteredCardsListTileState extends State<MyRegisteredCardsListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
          top: context.dynamicHeight(0.01),
          bottom: context.dynamicHeight(0.01)),
      tileColor: Colors.white,
      title: LocaleText(
        text: widget.title,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: AutoSizeText.rich(
        TextSpan(
          style:
              AppTextStyles.headlineStyle.copyWith(color: AppColors.textColor),
          children: [
            TextSpan(
              text: widget.subtitleBold,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
          ],
        ),
        textAlign: TextAlign.start,
        maxLines: 7,
      ),
      onTap: widget.onTap,
    );
  }
}
