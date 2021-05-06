import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class ChangeLocationListTile extends StatelessWidget {
  final String? cityText;
  final String? cityCodeText;

  const ChangeLocationListTile({
    Key? key,
    this.cityText,
    this.cityCodeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_CHECK_ICON,
      ),
      tileColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: context.dynamicWidht(0.06),
            child: Text(
              cityCodeText!,
              style: AppTextStyles.bodyTextStyle,
            ),
          ),
          Text(
            cityText!,
            style: AppTextStyles.bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
