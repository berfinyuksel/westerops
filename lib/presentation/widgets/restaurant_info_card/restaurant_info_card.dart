import '../restaurant_info_list_tile/first_column/packet_number.dart';
import '../restaurant_info_list_tile/first_column/restaurant_icon.dart';
import '../restaurant_info_list_tile/second_column/package_delivery.dart';
import '../restaurant_info_list_tile/third_column/available_time.dart';
import '../restaurant_info_list_tile/third_column/meters.dart';
import '../restaurant_info_list_tile/third_column/old_and_new_prices.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantInfoCard extends StatelessWidget {
  final String? packetNumber;
  final String? restaurantName;
  final String? grade;
  final String? location;
  final String? distance;
  final String? availableTime;
  const RestaurantInfoCard({
    Key? key,
    this.packetNumber,
    this.restaurantName,
    this.grade,
    this.location,
    this.distance,
    this.availableTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2E4EE).withOpacity(0.75),
            offset: Offset(0, 3.0),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            ImageConstant.COMMONS_RESTAURANT_IMAGE,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
            width: context.dynamicWidht(0.64),
            height: context.height > 800 ? context.dynamicHeight(0.16) : context.dynamicHeight(0.14),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.011), horizontal: context.dynamicWidht(0.023)),
            child: Column(
              children: [
                buildFirstRow(context, packetNumber!),
                Spacer(flex: 9),
                buildSecondRow(restaurantName!),
                Spacer(flex: 1),
                buildThirdRow(grade!, location!, distance!),
                Divider(
                  thickness: 2,
                  color: AppColors.borderAndDividerColor,
                ),
                buildForthRow(context, availableTime!)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildForthRow(BuildContext context, String availableTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AvailableTime(
          time: availableTime,
          width: context.dynamicWidht(0.26),
          height: context.dynamicHeight(0.04),
        ),
        OldAndNewPrices(
          width: context.dynamicWidht(0.16),
          height: context.dynamicHeight(0.04),
          textStyle: AppTextStyles.bodyBoldTextStyle,
        ),
      ],
    );
  }

  Row buildThirdRow(String grade, String location, String distance) {
    return Row(
      children: [
        SvgPicture.asset(ImageConstant.COMMONS_STAR_ICON),
        Text(
          " $grade   ",
          style: AppTextStyles.subTitleStyle,
        ),
        Spacer(flex: 13),
        Text(
          location,
          style: AppTextStyles.subTitleStyle,
        ),
        Spacer(flex: 14),
        Meters(
          distance: distance,
        ),
      ],
    );
  }

  Row buildSecondRow(String restaurantName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RestrauntIcon(),
        Text(
          restaurantName,
          style: AppTextStyles.bodyBoldTextStyle,
        ),
      ],
    );
  }

  Row buildFirstRow(BuildContext context, String packetNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PacketNumber(
          text: packetNumber,
          width: context.dynamicWidht(0.165),
          height: context.dynamicHeight(0.035),
        ),
        Spacer(),
        PackageDelivery(
          image: ImageConstant.COMMONS_GET_IT_ICON,
          color: Colors.white,
          backgroundColor: AppColors.greenColor,
          width: context.dynamicWidht(0.1),
          height: context.dynamicHeight(0.03),
        ),
        Container(
          margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
          child: PackageDelivery(
            image: ImageConstant.COMMONS_CARRIER_ICON,
            color: AppColors.unSelectedpackageDeliveryColor,
            backgroundColor: Colors.white,
            width: context.dynamicWidht(0.1),
            height: context.dynamicHeight(0.03),
          ),
        ),
      ],
    );
  }
}
