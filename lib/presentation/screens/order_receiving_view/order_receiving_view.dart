import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderReceivingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
    );
  }
}
