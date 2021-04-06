import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PaymentMethodFilterList extends StatefulWidget {
  PaymentMethodFilterList({Key? key}) : super(key: key);

  @override
  _PaymentMethodFilterListState createState() =>
      _PaymentMethodFilterListState();
}

class _PaymentMethodFilterListState extends State<PaymentMethodFilterList> {
  bool _valueOnline = false;
  bool _valueRestaurant = false;

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
                buildCheckBox(context),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_payment_method_item2,
                buildSecondCheckBox(context),
              ),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_payment_method_title);
  }

  Center buildSecondCheckBox(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        if (_valueRestaurant == false) {
          setState(() {
            _valueOnline = !_valueOnline;
          });
        } else {
          setState(() {
            _valueOnline = !_valueOnline;
            _valueRestaurant = !_valueRestaurant;
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
              color: _valueOnline ? AppColors.greenColor : Colors.transparent),
        ),
      ),
    ));
  }

  Center buildCheckBox(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        if (_valueOnline == false) {
          setState(() {
            _valueRestaurant = !_valueRestaurant;
          });
        } else {
          setState(() {
            _valueRestaurant = !_valueRestaurant;
            _valueOnline = !_valueOnline;
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
              color:
                  _valueRestaurant ? AppColors.greenColor : Colors.transparent),
        ),
      ),
    ));
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
