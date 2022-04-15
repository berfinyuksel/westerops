import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomCheckbox extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? checkboxColor;
  const CustomCheckbox({Key? key, this.onTap, this.checkboxColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 22.h,
          height: 22.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: const Color(0xFFD1D0D0),
            ),
          ),
          child: Icon(
            Icons.check,
            size: 18.h,
            color: checkboxColor,
          ),
        ),
      ),
    );
  }
}
