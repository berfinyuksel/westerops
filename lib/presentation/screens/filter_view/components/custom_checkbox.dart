import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Color? checkboxColor;
  const CustomCheckbox({
    Key? key, this.checkboxColor,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: context.dynamicWidht(0.06),
        height: context.dynamicHeight(0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color(0xFFD1D0D0),
          ),
        ),
        child: Container(
          width: context.dynamicWidht(0.04),
          height: context.dynamicHeight(0.04),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _value ? AppColors.greenColor : Colors.transparent),
        ),
      ),
    ));
  }
}
