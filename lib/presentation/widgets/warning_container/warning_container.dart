import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class WarningContainer extends StatelessWidget {
  final String? text;
  const WarningContainer({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.dynamicHeight(0.12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 2,
          ),
          SvgPicture.asset(ImageConstant.COMMONS_WARNING_ICON),
          Spacer(
            flex: 2,
          ),
          LocaleText(
            text: text,
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
