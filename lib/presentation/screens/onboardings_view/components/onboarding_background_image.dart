import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';

class OnboardingBackgroundImage extends StatelessWidget {
  final String? image;
  const OnboardingBackgroundImage({
    Key? key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.dynamicHeight(0.14)),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Image.asset(
        image!,
        fit: BoxFit.fill,
      ),
    );
  }
}
