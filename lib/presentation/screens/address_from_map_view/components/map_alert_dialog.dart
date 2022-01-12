import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';
import '../../address_detail_view/string_arguments/string_arguments.dart';

class MapAlertDialog extends StatelessWidget {
  final String? address;
  final String? district;

  const MapAlertDialog({Key? key, this.address, this.district})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.87),
        height: context.dynamicHeight(0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Spacer(flex: 2),
            SvgPicture.asset(
              ImageConstant.ADDRESS_MAP_ALERT,
              height: context.dynamicHeight(0.07),
            ),
            Spacer(flex: 1),
            LocaleText(
              text: LocaleKeys.address_from_map_alert_dialog_text,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 1),
            buildButtons(context),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Row buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          width: context.dynamicWidht(0.33),
          color: Colors.transparent,
          textColor: AppColors.greenColor,
          borderColor: AppColors.greenColor,
          title: LocaleKeys.surprise_pack_alert_button1,
          onPressed: () {
            // Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: context.dynamicWidht(0.01)),
        CustomButton(
          width: context.dynamicWidht(0.33),
          color: AppColors.greenColor,
          textColor: Colors.white,
          borderColor: AppColors.greenColor,
          title: LocaleKeys.surprise_pack_alert_button2,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstant.ADDRESS_DETAIL_VIEW,
                arguments: ScreenArguments(
                  title: LocaleKeys.address_from_map_title,
                  district: district!,
                  description: address!,
                ));
          },
        ),
      ],
    );
  }
}
