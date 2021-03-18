import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  const CustomContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicHeight(0.37),
      height: context.dynamicWidht(0.13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFD1D0D0),
        ),
      ),
      child: child,
    );
  }
}
