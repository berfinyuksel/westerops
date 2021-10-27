import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderStatusBar extends StatelessWidget {
  const OrderStatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: 93,
      color: AppColors.greenColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LocaleText(
                text: 'Aktif Siparişin',
                style: AppTextStyles.subTitleBoldStyle,
              ),
              LocaleText(
                text: 'Ev - 27 Şubat 2021  20:08',
                style: AppTextStyles.subTitleBoldStyle,
              ),
              LocaleText(
                text: 'Canım Büfe',
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          LocaleText(
            text: '01:52:00',
            style: AppTextStyles.subTitleBoldStyle,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
            width: 69,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: AppColors.scaffoldBackgroundColor,
            ),
            child: Text(
              '35 TL',
              style: AppTextStyles.bodyBoldTextStyle
                  .copyWith(color: AppColors.greenColor),
            ),
          ),
          SvgPicture.asset(
            ImageConstant.COMMONS_FORWARD_ICON,
            fit: BoxFit.fitWidth,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
