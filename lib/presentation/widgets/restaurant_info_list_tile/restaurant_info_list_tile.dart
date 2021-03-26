import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/second_column/grade_and_location.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/second_column/package_delivery.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/third_column/available_time.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/third_column/meters.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/third_column/old_and_new_prices.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'first_column/packet_number.dart';
import 'first_column/restaurant_icon.dart';

class RestaurantInfoListTile extends StatelessWidget {
  final String? packetNumber;
  final String? restaurantName;
  final String? distance;
  final String? availableTime;
  const RestaurantInfoListTile({
    Key? key,
    this.packetNumber,
    this.restaurantName,
    this.distance,
    this.availableTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      height: context.dynamicHeight(0.13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFirstColumn(context, packetNumber!),
          Spacer(flex: 1),
          buildSecondColumn(context, restaurantName!),
          Spacer(flex: 6),
          buildThirdColumn(context, distance!, availableTime!),
          Spacer(flex: 2),
          Center(child: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON))
        ],
      ),
    );
  }

  Column buildThirdColumn(BuildContext context, String distance, String availableTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Spacer(flex: 2),
        Meters(
          distance: distance,
        ),
        Spacer(flex: 1),
        AvailableTime(
          width: context.dynamicWidht(0.23),
          height: context.dynamicHeight(0.026),
          time: availableTime,
        ),
        Spacer(flex: 1),
        OldAndNewPrices(
          textStyle: AppTextStyles.subTitleBoldStyle,
          width: context.dynamicWidht(0.11),
          height: context.dynamicHeight(0.026),
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Column buildSecondColumn(BuildContext context, String restaurantName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(flex: 2),
        LocaleText(
          text: restaurantName,
          style: AppTextStyles.bodyBoldTextStyle,
        ),
        Spacer(flex: 1),
        GradeAndLocation(),
        Spacer(flex: 1),
        PackageDelivery(
          width: context.dynamicWidht(0.08),
          height: context.dynamicHeight(0.026),
          image: ImageConstant.COMMONS_GET_IT_ICON,
          backgroundColor: AppColors.greenColor,
          color: Colors.white,
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Column buildFirstColumn(BuildContext context, String packetNumber) {
    return Column(
      children: [
        Spacer(flex: 2),
        RestrauntIcon(),
        Spacer(flex: 1),
        PacketNumber(
          text: packetNumber,
          width: context.dynamicWidht(0.175),
          height: context.dynamicHeight(0.026),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
