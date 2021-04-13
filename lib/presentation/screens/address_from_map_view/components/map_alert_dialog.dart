import 'package:dongu_mobile/presentation/screens/address_detail_view/string_arguments/string_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MapAlertDialog extends StatelessWidget {
  final String? address;
  final String? district;

  const MapAlertDialog({Key? key, this.address, this.district}) : super(key: key);
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
              text: "Adresiniz haritada işaretlenen konuma göre\nkaydedilecektir. Konum işaretinin doğru\nolduğuna emin misiniz?",
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
          width: context.dynamicWidht(0.35),
          color: Colors.transparent,
          textColor: AppColors.greenColor,
          borderColor: AppColors.greenColor,
          title: LocaleKeys.surprise_pack_alert_button1,
        ),
        CustomButton(
          width: context.dynamicWidht(0.35),
          color: AppColors.greenColor,
          textColor: Colors.white,
          borderColor: AppColors.greenColor,
          title: LocaleKeys.surprise_pack_alert_button2,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstant.ADDRESS_DETAIL_VIEW, arguments: ScreenArguments("Yeni Adres Ekle", district!, address!));
          },
        ),
      ],
    );
  }
}
