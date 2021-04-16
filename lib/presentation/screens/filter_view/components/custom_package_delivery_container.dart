import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_checkbox.dart';
import 'custom_container.dart';

class CustomContainerPackageDelivery extends StatefulWidget {
  CustomContainerPackageDelivery({Key? key}) : super(key: key);

  @override
  _CustomContainerPackageDeliveryState createState() =>
      _CustomContainerPackageDeliveryState();
}

class _CustomContainerPackageDeliveryState
    extends State<CustomContainerPackageDelivery> {
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
              buildCheckBox(context, false),
              Spacer(flex: 3),
              buildPackageContainer(context, false),
              Spacer(flex: 5),
            ],
          ),
          Spacer(flex: 2),
          Row(
            children: [
              Spacer(flex: 4),
              buildCheckBox(context, true),
              Spacer(flex: 3),
              buildMotorCourierDeliveryContainer(context, true),
              Spacer(flex: 5),
            ],
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }

  Builder buildPackageContainer(BuildContext context, bool checkState) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomContainer(
        child: Row(
          children: [
            Spacer(flex: 5),
            SvgPicture.asset(
              ImageConstant.PACKAGE_ICON,
              color: checkState == true
                  ? state.checkboxTakeOutPackage!
                      ? AppColors.greenColor
                      : Colors.white
                  : state.checkboxMotorCourier!
                      ? AppColors.greenColor
                      : AppColors.unSelectedpackageDeliveryColor,
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
      );
    });
  }

  Builder buildMotorCourierDeliveryContainer(
      BuildContext context, bool checkState) {
      return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomContainer(
        child: Row(
          children: [
            Spacer(flex: 5),
            SvgPicture.asset(
              ImageConstant.PACKAGE_DELIVERY_ICON,
              color: checkState == false
                  ? state.checkboxMotorCourier!
                      ? AppColors.greenColor
                      : Colors.white
                  : state.checkboxTakeOutPackage!
                      ? AppColors.greenColor
                      : AppColors.unSelectedpackageDeliveryColor,
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
      );
    });
  }

  Builder buildCheckBox(BuildContext context, bool checkState) {
    return Builder(
      builder: (context) {
        final FiltersState state = context.watch<FiltersCubit>().state;
        return CustomCheckbox(
          onTap: () {
            setState(() {
              if (checkState == false) {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxMotorCourier(!state.checkboxMotorCourier!);
                context.read<FiltersCubit>().setIsCheckboxTakeOutPackage(false);
              } else {
                context.read<FiltersCubit>().setIsCheckboxTakeOutPackage(
                    !state.checkboxTakeOutPackage!);
                context.read<FiltersCubit>().setIsCheckboxMotorCourier(false);
              }
            });
          },
          checkboxColor: checkState == false
              ? state.checkboxMotorCourier!
                  ? AppColors.greenColor
                  : Colors.white
              : state.checkboxTakeOutPackage!
                  ? AppColors.greenColor
                  : Colors.white,
        );
      },
    );
  }
}
