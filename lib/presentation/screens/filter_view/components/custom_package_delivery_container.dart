import '../../../../logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../logic/cubits/filters_cubit/filters_cubit.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
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
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

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
                buildPackageContainer(context, false, () {
                  setState(() {
                    state.checkList![4] = !state.checkList![4];
                    state.checkList![5] = false;
                  });
                }),
                Spacer(flex: 5),
              ],
            ),
            Spacer(flex: 1),
            Row(
              children: [
                Spacer(flex: 4),
                buildCheckBox(context, true),
                Spacer(flex: 3),
                buildMotorCourierDeliveryContainer(context, true, () {
                  setState(() {
                    state.checkList![5] = !state.checkList![5];
                  });
                }),
                Spacer(flex: 5),
              ],
            ),
            Spacer(flex: 4),
          ],
        ),
      );
    });
  }

  Builder buildPackageContainer(
      BuildContext context, bool checkState, VoidCallback onTap) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;
      context.read<FiltersManagerCubit>().getPackageDelivery(state.checkList![5]);
      return GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          child: Row(
            children: [
              Spacer(flex: 5),
              SvgPicture.asset(
                ImageConstant.PACKAGE_ICON,
                color: checkState == true
                    ? state.checkList![5]
                        ? AppColors.greenColor
                        : Colors.white
                    : state.checkList![4] //motor
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
        ),
      );
    });
  }

  Builder buildMotorCourierDeliveryContainer(
      BuildContext context, bool checkState, VoidCallback onTap) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          child: Row(
            children: [
              Spacer(flex: 5),
              SvgPicture.asset(
                ImageConstant.PACKAGE_DELIVERY_ICON,
                color: checkState == false
                    ? state.checkList![4]
                        ? AppColors.greenColor
                        : Colors.white
                    : state.checkList![5]
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
                state.checkList![4] = !state.checkList![4];
              } else {
                state.checkList![5] = !state.checkList![5];
              }
            });
          },
          checkboxColor: checkState == false
              ? state.checkList![4]
                  ? AppColors.greenColor
                  : Colors.white
              : state.checkList![5]
                  ? AppColors.greenColor
                  : Colors.white,
        );
      },
    );
  }
}
