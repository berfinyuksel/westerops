import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class WasDeliveredView extends StatefulWidget {
  final OrderReceived? orderInfo;
  const WasDeliveredView({Key? key, this.orderInfo}) : super(key: key);
  @override
  _WasDeliveredViewState createState() => _WasDeliveredViewState();
}

class _WasDeliveredViewState extends State<WasDeliveredView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.scaffoldBackgroundColor,
            child: SvgPicture.asset(
              ImageConstant.ORDER_RECEIVING_BACKGROUND,
              fit: BoxFit.cover,
            ),
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                Spacer(
                  flex: 7,
                ),
                LocaleText(
                  text: "Siparişinizi Teslim Edildi",
                  style: AppTextStyles.appBarTitleStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.orangeColor),
                ),
                Spacer(
                  flex: 4,
                ),
                LocaleText(
                  text: "Sipariş Numarası:",
                  style: AppTextStyles.myInformationBodyTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                LocaleText(
                  text: widget.orderInfo!.refCode!.toString(),
                  style: AppTextStyles.headlineStyle,
                ),
                Container(
                  child: SvgPicture.asset(ImageConstant.ORDER_DELIVERED_ICON),
                ),
                Spacer(
                  flex: 4,
                ),

                LocaleText(
                  text:
                      "Dünyayı korumamıza\nyardımcı olduğun için\nteşekkürler!",
                  style: AppTextStyles.headlineStyle,
                  maxLines: 3,
                  alignment: TextAlign.center,
                ),
                Spacer(
                  flex: 2,
                ),

                LocaleText(
                  text:
                      "Gezegenimizi korumak çıktığımız bu yolda\nbizi yalnız bırakmadığın için teşekkürler!\nŞimdi sıra siparişini puanlamada!",
                  alignment: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 3,
                ),
                Spacer(
                  flex: 3,
                ),

                CustomButton(
                  title: "Değerlendir",
                  textColor: Colors.white,
                  width: context.dynamicWidht(0.86),
                  color: AppColors.greenColor,
                  borderColor: AppColors.greenColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                            arguments: ScreenArgumentsRestaurantDetail(
                              orderInfo: widget.orderInfo,
                            ));
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(
                  flex: 4,
                ),

                // infoCard(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}
