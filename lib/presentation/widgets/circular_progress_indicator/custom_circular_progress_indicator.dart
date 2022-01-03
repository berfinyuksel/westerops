import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  static final Color color = Color(0xFFffbc41);
  const CustomCircularProgressIndicator({Key? key, String? color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
    );
  }
}
