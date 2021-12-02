import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/order_received.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';

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
                  flex: 2,
                ),
                LocaleText(
                  text: "Siparişinizi Teslim Edildi",
                  style: AppTextStyles.appBarTitleStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.orangeColor),
                ),
                Spacer(
                  flex: 1,
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
                Spacer(
                  flex: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 10),
                          LocaleText(
                            text: 'Restoran Adi',
                            style: AppTextStyles.appBarTitleStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangeColor),
                          ),
                          Spacer(),
                          LocaleText(
                            text: 'Restoran Adresi',
                            style: AppTextStyles.appBarTitleStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangeColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(widget.orderInfo!.boxes!.first.store!.name!),
                          Spacer(),
                          Text(widget.orderInfo!.boxes!.first.store!.address!),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: context.dynamicHeight(0.3),
                  child: SvgPicture.asset(ImageConstant.ORDER_DELIVERED_ICON),
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
