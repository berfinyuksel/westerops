import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  const CustomSearchBar({Key? key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
       
        Container(
          width: context.dynamicWidht(0.9),
          height: context.dynamicWidht(0.12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(25.0),
              right: Radius.circular(4.0),
            ),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: context.dynamicWidht(0.15),
            ),
            child: TextField(
              onChanged: (value) {
                //filterSearchResults(value);
              },
              onTap: () {
                /*setState(() {
                  _valueSearch = !_valueSearch;
                });*/
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            //  controller: controller,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.13),
          height: context.dynamicHeight(0.13),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.yellowColor,
          ),
          child: SvgPicture.asset(
            // search
            ImageConstant.SEARCH_ICON,
            width: context.dynamicWidht(0.039),
            height: context.dynamicHeight(0.058),
          ),
        ),
      ],
    );
  }
}
