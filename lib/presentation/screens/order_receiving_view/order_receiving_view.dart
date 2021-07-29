import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class OrderReceivingView extends StatefulWidget {
  @override
  _OrderReceivingViewState createState() => _OrderReceivingViewState();
}

class _OrderReceivingViewState extends State<OrderReceivingView> {
  @override
  void initState() {
    super.initState();
    sleep();
  }

  Future<void> sleep() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, RouteConstant.ORDER_RECEIVED_VIEW);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.scaffoldBackgroundColor,
            child: SvgPicture.asset(ImageConstant.ORDER_RECEIVING_BACKGROUND),
          ),
          Center(
            child: Column(
              children: [
                Spacer(
                  flex: 201,
                ),
                SvgPicture.asset(ImageConstant.ORDER_RECEIVING_DONGU_LOGO),
                Spacer(
                  flex: 129,
                ),
                SvgPicture.asset(ImageConstant.ORDER_RECEIVING_PACKAGE_ICON),
                Spacer(
                  flex: 183,
                ),
                LocaleText(
                  text: "Siparişiniz alınıyor…",
                  style: AppTextStyles.headlineStyle,
                ),
                Spacer(
                  flex: 197,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
