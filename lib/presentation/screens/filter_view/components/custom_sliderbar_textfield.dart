import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class CustomSliderBarAndTextField extends StatefulWidget {
  CustomSliderBarAndTextField({Key? key}) : super(key: key);

  @override
  _CustomSliderBarAndTextFieldState createState() =>
      _CustomSliderBarAndTextFieldState();
}

class _CustomSliderBarAndTextFieldState
    extends State<CustomSliderBarAndTextField> {
  int _starValue = 10;
  int _endValue = 50;
  int minValue = 10;
  int maxValue = 500;

  final startController = TextEditingController();
  final endController = TextEditingController();
  @override
  void initState() {
    super.initState();

    startController.addListener(_setStartValue);
    endController.addListener(_setEndValue);
  }

  _setStartValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _starValue = double.parse(startController.text).roundToDouble().toInt();
      });
    }
    print("Second text field: ${startController.text}");
  }

  _setEndValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _endValue = double.parse(endController.text).roundToDouble().toInt();
      });
    }
    print("Second text field: ${endController.text}");
  }

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //   width: context.dynamicWidht(0.9),
      height: context.dynamicHeight(0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 50, child: rangeSliderBar()),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(
                  flex: 3,
                ),
                minPrice(context),
                Spacer(
                  flex: 1,
                ),
                maxPrice(context),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 25,
          )
        ],
      ),
    );
  }

  Container maxPrice(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.39),
      height: context.dynamicHeight(0.060),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFD1D0D0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  AutoSizeText(
                    LocaleKeys.filters_package_price_item2.locale,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  Spacer(flex: 7),
                ],
              )),
          Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 2),
                Container(
                  height: context.dynamicHeight(0.25),
                  width: context.dynamicWidht(0.35),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: LocaleKeys.filters_package_price_item3.locale,
                        hintStyle: AppTextStyles.subTitleStyle
                            .copyWith(fontWeight: FontWeight.bold)),
                    controller: endController,
                    cursorColor: AppColors.textColor,
                  ),
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container minPrice(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.39),
      height: context.dynamicHeight(0.060),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFD1D0D0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  AutoSizeText(
                    LocaleKeys.filters_package_price_item1.locale,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  Spacer(flex: 7),
                ],
              )),
          Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 2),
                Container(
                  height: context.dynamicHeight(0.25),
                  width: context.dynamicWidht(0.35),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: LocaleKeys.filters_package_price_item3.locale,
                        hintStyle: AppTextStyles.subTitleStyle
                            .copyWith(fontWeight: FontWeight.bold)),
                    controller: startController,
                    cursorColor: AppColors.textColor,
                  ),
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container rangeSliderBar() {
    return Container(
      width: context.dynamicWidht(0.92),
      child: SliderTheme(
        data: SliderThemeData(trackHeight: 7),
        child: RangeSlider(
          values: RangeValues(_starValue.toDouble(), _endValue.toDouble()),
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          inactiveColor: AppColors.sliderColor,
          activeColor: AppColors.greenColor,
          onChanged: (values) {
            setState(() {
              _starValue = values.start.roundToDouble().toInt();
              _endValue = values.end.roundToDouble().toInt();
              startController.text =
                  values.start.roundToDouble().toInt().toString();
              endController.text =
                  values.end.roundToDouble().toInt().toString();
            });
          },
        ),
      ),
    );
  }
}
