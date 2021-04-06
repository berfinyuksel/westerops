import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_container.dart';

class CustomContainerPackageDelivery extends StatefulWidget {
  CustomContainerPackageDelivery({Key? key}) : super(key: key);

  @override
  _CustomContainerPackageDeliveryState createState() =>
      _CustomContainerPackageDeliveryState();
}

class _CustomContainerPackageDeliveryState
    extends State<CustomContainerPackageDelivery> {
  bool _valuePackage = false;
  bool _valueCoruier = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.23),
      child: Column(
        children: [
          Spacer(flex: 2),
          Row(
            children: [
              Spacer(flex: 4),
              Center(
                  child: InkWell(
                onTap: () {
                  if (_valueCoruier == false) {
                    setState(() {
                      _valuePackage = !_valuePackage;
                    });
                  } else {
                    setState(() {
                      _valuePackage = !_valuePackage;
                      _valueCoruier = !_valueCoruier;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: context.dynamicWidht(0.051),
                  height: context.dynamicHeight(0.023),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFD1D0D0),
                    ),
                  ),
                  child: Container(
                    width: context.dynamicWidht(0.032),
                    height: context.dynamicHeight(0.015),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _valuePackage
                            ? AppColors.greenColor
                            : Colors.transparent),
                  ),
                ),
              )),
              Spacer(flex: 3),
              CustomContainer(
                child: Row(
                  children: [
                    Spacer(flex: 5),
                    SvgPicture.asset(
                      ImageConstant.PACKAGE_ICON,
                      color: _valuePackage
                          ? AppColors.greenColor
                          : AppColors.iconColor,
                    ),
                    Spacer(flex: 13),
                    Center(
                        child: LocaleText(
                      text: LocaleKeys.filters_package_delivery_item1,
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    )),
                    Spacer(flex: 24),
                  ],
                ),
              ),
              Spacer(flex: 5),
            ],
          ),
          Spacer(flex: 2),
          Row(
            children: [
              Spacer(flex: 4),
              Center(
                  child: InkWell(
                onTap: () {
                  if (_valuePackage == false) {
                    setState(() {
                      _valueCoruier = !_valueCoruier;
                    });
                  } else {
                    setState(() {
                      _valuePackage = !_valuePackage;
                      _valueCoruier = !_valueCoruier;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: context.dynamicWidht(0.051),
                  height: context.dynamicHeight(0.023),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFD1D0D0),
                    ),
                  ),
                  child: Container(
                    width: context.dynamicWidht(0.032),
                    height: context.dynamicHeight(0.015),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _valueCoruier
                            ? AppColors.greenColor
                            : Colors.transparent),
                  ),
                ),
              )),
              Spacer(flex: 3),
              CustomContainer(
                child: Row(
                  children: [
                    Spacer(flex: 5),
                    SvgPicture.asset(
                      ImageConstant.PACKAGE_DELIVERY_ICON,
                      color: _valueCoruier
                          ? AppColors.greenColor
                          : AppColors.iconColor,
                      // cubit --> color:  Colors.red
                    ),
                    Spacer(flex: 13),
                    Center(
                        child: LocaleText(
                      text: LocaleKeys.filters_package_delivery_item2,
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    )),
                    Spacer(flex: 24),
                  ],
                ),
              ),
              Spacer(flex: 5),
            ],
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
