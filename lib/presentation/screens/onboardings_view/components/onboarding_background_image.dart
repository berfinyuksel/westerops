import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      padding: EdgeInsets.only(top: context.dynamicHeight(0.0)),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SvgPicture.asset(
        image!,
        fit: BoxFit.cover,
      ),
    );
  }
}
