import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradeAndLocation extends StatelessWidget {
  const GradeAndLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(ImageConstant.COMMONS_STAR_ICON),
        Text(
          " 4.7   ",
          style: AppTextStyles.subTitleStyle,
        ),
        Text(
          "Beşiktaş",
          style: AppTextStyles.subTitleStyle,
        ),
      ],
    );
  }
}
