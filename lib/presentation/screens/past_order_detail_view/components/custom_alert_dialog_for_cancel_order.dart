import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';

class CustomAlertDialogForCancelOrder extends StatefulWidget {
  final String? textMessage;
  final String? buttonOneTitle;
  final String? buttonTwoTittle;
  final String? imagePath;
  final VoidCallback? onPressedOne;
  final VoidCallback? onPressedTwo;
  final TextEditingController? customTextController;
  CustomAlertDialogForCancelOrder({
    required this.textMessage,
    required this.customTextController,
    required this.buttonOneTitle,
    required this.buttonTwoTittle,
    required this.imagePath,
    required this.onPressedOne,
    required this.onPressedTwo,
  });

  @override
  State<CustomAlertDialogForCancelOrder> createState() =>
      _CustomAlertDialogForCancelOrderState();
}

class _CustomAlertDialogForCancelOrderState
    extends State<CustomAlertDialogForCancelOrder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.87),
        height: context.dynamicHeight(0.32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 90,
              width: 90,
              child: SvgPicture.asset(
                widget.imagePath!,
              ),
            ),
            SizedBox(height: 10),
            LocaleText(
              text: widget.textMessage,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(height: 10),
            buildTextFormField(
                LocaleKeys.surprise_pack_cancel_descrption.locale,
                widget.customTextController!,
                context),
            SizedBox(height: 10),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Builder buildButtons(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            onPressed: widget.onPressedOne,
            width: context.dynamicWidht(0.35),
            color: Colors.transparent,
            textColor: AppColors.greenColor,
            borderColor: AppColors.greenColor,
            title: widget.buttonOneTitle,
          ),
          CustomButton(
            onPressed: widget.onPressedTwo,
            width: context.dynamicWidht(0.35),
            color: AppColors.greenColor,
            textColor: Colors.white,
            borderColor: AppColors.greenColor,
            title: this.widget.buttonTwoTittle,
          ),
        ],
      );
    });
  }

  Container buildTextFormField(
      String hintText, TextEditingController controller, BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.052),
      color: Colors.white,
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.subTitleStyle,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
