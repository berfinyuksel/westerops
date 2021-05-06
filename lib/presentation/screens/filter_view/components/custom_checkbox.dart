import '../../../../utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? checkboxColor;
  const CustomCheckbox({Key? key, this.onTap, this.checkboxColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: onTap,
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
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: checkboxColor),
        ),
      ),
    ));
  }
}