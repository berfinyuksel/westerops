import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundOnboarding extends StatelessWidget {
  final String image;
  const BackgroundOnboarding({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.55),
        Expanded(
          child: SvgPicture.asset(
                  image,
                  fit: BoxFit.fill,
                ),
        ),
      ],
    );
  }
}
