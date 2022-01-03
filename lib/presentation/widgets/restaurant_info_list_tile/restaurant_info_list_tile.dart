import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'first_column/packet_number.dart';
import 'first_column/restaurant_icon.dart';
import 'second_column/grade_and_location.dart';
import 'second_column/package_delivery.dart';
import 'third_column/available_time.dart';
import 'third_column/meters.dart';
import 'third_column/old_and_new_prices.dart';

class RestaurantInfoListTile extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? packetNumber;
  final String? restaurantName;
  final String? distance;
  final String? availableTime;
  final Border? border;
  final String? icon;
  final int? minOrderPrice;
  final int? minDiscountedOrderPrice;
  final int? deliveryType;

  const RestaurantInfoListTile({
    Key? key,
    @required this.packetNumber,
    @required this.restaurantName,
    @required this.distance,
    @required this.availableTime,
    @required this.onPressed,
    @required this.minOrderPrice,
    @required this.minDiscountedOrderPrice,
    @required this.deliveryType,
    this.border,
    this.icon,
  }) : super(key: key);

  @override
  State<RestaurantInfoListTile> createState() => _RestaurantInfoListTileState();
}

class _RestaurantInfoListTileState extends State<RestaurantInfoListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: widget.border),
      padding: EdgeInsets.fromLTRB(
        8,
        context.dynamicHeight(0.02),
        2,
        context.dynamicHeight(0.02),
      ),
      height: context.dynamicHeight(0.13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFirstColumn(context, widget.packetNumber!, widget.icon!),
          SizedBox(
            width: 5,
          ),
          buildSecondColumn(context, widget.restaurantName!),
          Spacer(flex: 6),
          buildThirdColumn(context, widget.distance!, widget.availableTime!),
          Spacer(),
          IconButton(
              onPressed: widget.onPressed,
              icon: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON))
        ],
      ),
    );
  }

  Column buildThirdColumn(
      BuildContext context, String distance, String availableTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Meters(
          distance: "${(double.parse(distance) / 1000).toStringAsFixed(2)}",
        ),
        Spacer(flex: 1),
        AvailableTime(
          width: context.dynamicWidht(0.23),
          height: context.dynamicHeight(0.026),
          time: availableTime,
        ),
        Spacer(flex: 1),
        OldAndNewPrices(
          minOrderPrice: widget.minOrderPrice,
          minDiscountedOrderPrice: widget.minDiscountedOrderPrice,
          textStyle: AppTextStyles.subTitleBoldStyle,
          width: context.dynamicWidht(0.11),
          height: context.dynamicHeight(0.026),
        ),
      ],
    );
  }

  Column buildSecondColumn(BuildContext context, String restaurantName) {
    bool deliveryTypeForCourier = false;
    bool deliveryTypeForGetIt = true;

    if (widget.deliveryType == 1) {
      deliveryTypeForGetIt = true;
      deliveryTypeForCourier = false;
    } else if (widget.deliveryType == 2) {
      deliveryTypeForGetIt = false;
      deliveryTypeForCourier = true;
    } else {
      deliveryTypeForGetIt = true;
      deliveryTypeForCourier = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.dynamicWidht(0.3),
          child: Text(
            restaurantName,
            style: AppTextStyles.bodyBoldTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacer(flex: 1),
        GradeAndLocation(),
        Spacer(flex: 1),
        Row(
          children: [
            Visibility(
              visible: deliveryTypeForCourier,
              child: PackageDelivery(
                width: context.dynamicWidht(0.1),
                height: context.dynamicHeight(0.03),
                image: ImageConstant.COMMONS_CARRIER_ICON,
                color: Colors.white,
                backgroundColor: AppColors.greenColor,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Visibility(
              visible: deliveryTypeForGetIt,
              child: PackageDelivery(
                width: context.dynamicWidht(0.1),
                height: context.dynamicHeight(0.03),
                image: ImageConstant.RESTAURANT_PACKAGE_ICON,
                color: Colors.white,
                backgroundColor: AppColors.greenColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildFirstColumn(
      BuildContext context, String packetNumber, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RestrauntIcon(
          icon: icon, // null
        ),
        Spacer(flex: 1),
        PacketNumber(
          text: packetNumber,
          width: context.dynamicWidht(0.175),
          height: context.dynamicHeight(0.03),
        ),
      ],
    );
  }
}
