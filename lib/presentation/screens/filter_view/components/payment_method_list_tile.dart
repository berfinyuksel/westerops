import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_cubit.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_checkbox.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodFilterList extends StatefulWidget {
  PaymentMethodFilterList({Key? key}) : super(key: key);

  @override
  _PaymentMethodFilterListState createState() =>
      _PaymentMethodFilterListState();
}

class _PaymentMethodFilterListState extends State<PaymentMethodFilterList> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
        expansionTileBody: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.074)),
          child: Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.01)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_payment_method_item1,
                buildCheckBox(context, false),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_payment_method_item2,
                buildCheckBox(context, true),
              ),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_payment_method_title);
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
                    .setIsCheckboxPaymentOnline(!state.checkboxOnlinePayment!);
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxPaymentRestaurant(false);
              } else {
                context.read<FiltersCubit>().setIsCheckboxPaymentRestaurant(
                    !state.checkboxRestaurantPayment!);
                context.read<FiltersCubit>().setIsCheckboxPaymentOnline(false);
              }
            });
          },
          checkboxColor: checkState == false
              ? state.checkboxOnlinePayment!
                  ? AppColors.greenColor
                  : Colors.white
              : state.checkboxRestaurantPayment!
                  ? AppColors.greenColor
                  : Colors.white,
        );
      },
    );
  }

  Row buildRowCheckboxAndText(
      BuildContext context, String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
        Spacer(flex: 2),
        LocaleText(text: text, style: AppTextStyles.bodyTextStyle),
        Spacer(flex: 35),
      ],
    );
  }
}
