import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class CustomSliderBarAndTextField extends StatefulWidget {
  CustomSliderBarAndTextField({Key? key}) : super(key: key);

  @override
  _CustomSliderBarAndTextFieldState createState() => _CustomSliderBarAndTextFieldState();
}

class _CustomSliderBarAndTextFieldState extends State<CustomSliderBarAndTextField> {
  double _starValue = 10;
  double _endValue = 50;
  double minValue = 10.0;
  double maxValue = 500.0;
  
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
        _starValue = double.parse(startController.text).roundToDouble();
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
        _endValue = double.parse(endController.text).roundToDouble();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Expanded(flex: 50, child: rangeSliderBar()),
            Spacer(flex: 3,),
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
                  flex: 3,
                ),
                  maxPrice(context),
                  Spacer(flex: 3,),
                ],
              ),
            ),
          Spacer(flex: 25,)
        ],
      ),
    );
  }

  Container maxPrice(BuildContext context) {
    return Container(
              width: context.dynamicWidht(0.45),
              height: context.dynamicHeight(0.075),
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
                  Expanded(flex: 2, child: AutoSizeText(LocaleKeys.filters_package_price_item2.locale,
                textAlign: TextAlign.start,
              )),
                  Spacer(flex: 2),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "TL",
                      ),
                       controller: endController,
                       cursorColor: AppColors.textColor, 
                    ),
                  ),
                ],
              ),
            );
  }

  Container minPrice(BuildContext context) {
    return Container(
              width: context.dynamicWidht(0.45),
              height: context.dynamicHeight(0.075),
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
                  Expanded(flex: 2, child: AutoSizeText(
                LocaleKeys.filters_package_price_item1.locale, textAlign: TextAlign.start,)),
                  Spacer(flex: 2),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "TL"
                      ),
                      controller: startController,
                      cursorColor: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            );
  }

  RangeSlider rangeSliderBar() {
    return RangeSlider(
          values: RangeValues(_starValue, _endValue),
          min: minValue,
          max: maxValue,
          inactiveColor: AppColors.sliderColor,
          activeColor: AppColors.greenColor,
          onChanged: (values) {
            setState(() {
              _starValue = values.start.roundToDouble();
              _endValue = values.end.roundToDouble();
              startController.text = values.start.roundToDouble().toString();
              endController.text = values.end.roundToDouble().toString();
            });
          },
        );
  }
}
/*
TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: '0 TL'),
              controller: startController,
              keyboardType: TextInputType.number,
        ),
   TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: '500 TL',),
              controller: endController,
              keyboardType: TextInputType.number,
        ),       
  double minValue = 0.0;
  double maxValue = 100.0;
  int _lira = 20;
 Slider(
            value: _lira.toDouble(),
            min: 10.0,
            max: 500.0,
            label: '$_lira TL',
            inactiveColor: AppColors.sliderColor,
            activeColor: AppColors.greenColor,
            onChanged: (double newValue) {
              print('$newValue');
              setState(() {
                _lira = newValue.round();
              });
            },
            semanticFormatterCallback: (double newValue) {
              return '${newValue.round()} TL';
            }),
            
            
            Container(
      width: 170.0,
      height: 50.0,
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
          Expanded(flex: 2, child: text!),
          Spacer(flex: 2),
          Expanded(
            flex: 2,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    )
            
            */
