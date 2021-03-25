import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class PastOrderListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? price;
  const PastOrderListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: context.dynamicWidht(0.07)),
            width: 69.0,
            height: 36.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: AppColors.scaffoldBackgroundColor,
            ),
            child: Text(
              '$price TL',
              style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.greenColor),
            ),
          ),
          SvgPicture.asset(
            ImageConstant.COMMONS_FORWARD_ICON,
          ),
        ],
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