import 'package:flutter/material.dart';

import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';

import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class PacketNumber extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final bool? isInactive;
  const PacketNumber({
    Key? key,
    this.text,
    this.width,
    this.height,
    this.isInactive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: text == LocaleKeys.home_page_soldout_icon.locale || isInactive!
              ? AppColors.disabledButtonColor
              : AppColors.orangeColor),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: AppTextStyles.subTitleBoldStyle,
      ),
    );
  }
}
