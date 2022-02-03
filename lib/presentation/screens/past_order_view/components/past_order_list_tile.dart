import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PastOrderListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? price;
  final VoidCallback? onTap;
  final bool? statusSituationForCancel;
  const PastOrderListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.price,
    this.onTap,
    this.statusSituationForCancel = false,
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
          Visibility(
              visible: statusSituationForCancel!,
              child: LocaleText(
                textOverFlow: TextOverflow.ellipsis,
                text: LocaleKeys.past_order_cancel_button,
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(color: AppColors.redColor),
              )),
          SizedBox(
            width: 5,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: context.dynamicWidht(0.07)),
            width: context.dynamicWidht(0.16),
            height: context.dynamicHeight(0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: AppColors.scaffoldBackgroundColor,
            ),
            child: Text(
              '$price TL',
              style: AppTextStyles.bodyBoldTextStyle
                  .copyWith(color: AppColors.greenColor),
            ),
          ),
          SvgPicture.asset(
            ImageConstant.COMMONS_FORWARD_ICON,
          ),
        ],
      ),
      tileColor: Colors.white,
      title: Text(
        title!,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: Text(
        subtitle!,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      onTap: onTap,
    );
  }
}
