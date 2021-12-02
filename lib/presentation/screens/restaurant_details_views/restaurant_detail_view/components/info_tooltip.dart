import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/image_constant.dart';
import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';



class ClippedInfo extends StatelessWidget {
  const ClippedInfo({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit, sed do eiusmod tempor incididunt '
            'ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation '
            'ullamco laboris nisi ut aliquip ex ea commodo consequat',
        padding: EdgeInsets.only(
          left: context.dynamicWidht(0.03),
          bottom: context.dynamicWidht(0.03),
          top: context.dynamicWidht(0.03),
          right: context.dynamicWidht(0.03),
        ),
        height: context.dynamicHeight(0.1),
        showDuration: Duration(seconds: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE2E4EE).withOpacity(0.75),
              offset: Offset(0, 3.0),
              blurRadius: 12.0,
            ),
          ],
        ),
        textStyle:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.bold),
        preferBelow: true,
        verticalOffset: 20,
        child: SvgPicture.asset(ImageConstant.RESTAURANT_INFO_ICON));
  }
}
