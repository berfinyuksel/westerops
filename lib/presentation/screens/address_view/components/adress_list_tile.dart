import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class AddressListTile extends StatelessWidget {
  final String? title;
  final String? subtitleBold;
  final String? subtitle;

  const AddressListTile({
    Key? key,
    this.title,
    this.subtitleBold,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Container(
        height: double.infinity,
        width: context.dynamicWidht(0.03),
        child: SvgPicture.asset(
          ImageConstant.COMMONS_FORWARD_ICON,
          fit: BoxFit.fitWidth,
        ),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: AutoSizeText.rich(
        TextSpan(
          style: AppTextStyles.headlineStyle.copyWith(color: AppColors.textColor),
          children: [
            TextSpan(
              text: subtitleBold,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            TextSpan(
              text: subtitle,
              style: AppTextStyles.subTitleStyle,
            ),
          ],
        ),
        textAlign: TextAlign.start,
        maxLines: 7,
      ),
      onTap: () {},
    );
  }
}
