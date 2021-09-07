import 'package:dongu_mobile/data/model/box.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboardings_view.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          milliseconds: 5600,
        ), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnboardingsView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          child: LottieBuilder.asset(
      ImageConstant.SPLASH_ANIMATION,
      fit: BoxFit.cover,
    ),
        ));
  }
}
