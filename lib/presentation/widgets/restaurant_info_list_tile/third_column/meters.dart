import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class Meters extends StatelessWidget {
  final String? distance;
  const Meters({
    Key? key,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: context.dynamicHeight(0.005)),
          child: SvgPicture.asset(
            ImageConstant.COMMONS_METERS_ICON,
          ),
        ),
        Text(
          " ${distance!}",
          style: AppTextStyles.subTitleBoldStyle.copyWith(color: AppColors.orangeColor),
        )
      ],
    );
  }
}
