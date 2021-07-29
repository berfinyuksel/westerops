import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Widget? textButton;
  final double? containerPadding;
  const CustomSearchBar(
      {Key? key,
      this.hintText,
      this.focusNode,
      this.controller,
      this.onTap,
      this.onChanged,
      this.textButton, this.containerPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: containerPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
            ),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onTap: onTap,
            cursorColor: AppColors.cursorColor,
            style: AppTextStyles.bodyTextStyle,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right:context.dynamicWidht(0.04)),
                  child: SvgPicture.asset(
                    ImageConstant.COMMONS_SEARCH_ICON,
                  ),
                ),
                
                border: buildOutlineInputBorder(),
                focusedBorder: buildOutlineInputBorder(),
                enabledBorder: buildOutlineInputBorder(),
                errorBorder: buildOutlineInputBorder(),
                disabledBorder: buildOutlineInputBorder(),
                contentPadding:
                    EdgeInsets.only(left: context.dynamicWidht(0.046)),
                hintText: "Yemek, restoran ara"),
          ),
        ),
        SizedBox(width: context.dynamicWidht(0.01),),
        textButton?? SizedBox()
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        bottomLeft: Radius.circular(25.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }
}
