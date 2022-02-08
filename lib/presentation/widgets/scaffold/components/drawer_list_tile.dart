import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../text/locale_text.dart';

class DrawerListTile extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const DrawerListTile({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 32.w,
        right: 29.w,
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_FORWARD_ICON,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title,
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: onTap,
    );
  }
}
