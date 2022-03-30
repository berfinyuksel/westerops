import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/services/locator.dart';
import '../../../logic/cubits/box_cubit/box_state.dart';
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

  final String? restaurantName;
  final String? distance;
  final String? availableTime;
  final Border? border;
  final String? icon;
  final int? minOrderPrice;
  final int? minDiscountedOrderPrice;
  final int? deliveryType;
  final int restaurantId;

  const RestaurantInfoListTile({
    Key? key,
    @required this.restaurantName,
    @required this.distance,
    @required this.availableTime,
    @required this.onPressed,
    @required this.minOrderPrice,
    @required this.minDiscountedOrderPrice,
    @required this.deliveryType,
    this.border,
    this.icon,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantInfoListTile> createState() => _RestaurantInfoListTileState();
}

class _RestaurantInfoListTileState extends State<RestaurantInfoListTile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BoxCubit>()..getBoxes(widget.restaurantId),
      child: Card(
        child: Container(
          decoration: BoxDecoration(color: Colors.white, border: widget.border),
          padding: EdgeInsets.all(10.w),
          height: 124.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildFirstColumn(context, widget.icon!),
              Spacer(),
              buildSecondColumn(context, widget.restaurantName!),
              // Spacer(flex: 4),
              buildThirdColumn(
                  context, widget.distance!, widget.availableTime!),
              Spacer(),
              GestureDetector(
                  onTap: widget.onPressed,
                  child: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON)),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildThirdColumn(
      BuildContext context, String distance, String availableTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Meters(
          distance: "${(double.parse(distance) / 100000).toStringAsFixed(2)}",
        ),
        Spacer(flex: 1),
        AvailableTime(
          width: 120.w,
          height: 24.h,
          time: availableTime,
        ),
        Spacer(flex: 1),
        OldAndNewPrices(
          minOrderPrice: widget.minOrderPrice,
          minDiscountedOrderPrice: widget.minDiscountedOrderPrice,
          textStyle: AppTextStyles.subTitleBoldStyle,
          width: context.dynamicWidht(0.11),
          height: 24.h,
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
          color: Colors.white,
          width: 140.w,
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
              visible: deliveryTypeForGetIt,
              child: PackageDelivery(
                width: 40.w,
                height: 30.h,
                image: ImageConstant.RESTAURANT_PACKAGE_ICON,
                color: Colors.white,
                backgroundColor: AppColors.greenColor,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Visibility(
              visible: deliveryTypeForCourier,
              child: PackageDelivery(
                width: 40.w,
                height: 30.h,
                image: ImageConstant.COMMONS_CARRIER_ICON,
                color: Colors.white,
                backgroundColor: AppColors.greenColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildFirstColumn(BuildContext context, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RestrauntIcon(
          icon: icon, // null
        ),
        Spacer(flex: 1),
        BlocBuilder<BoxCubit, BoxState>(
          builder: (context, state) {
            if (state is BoxLoading) {
              return SizedBox();
            } else if (state is BoxCompleted) {
              return PacketNumber(
                text: state.packages.length != 0
                    ? "${state.packages.length.toString()} paket"
                    : "tükendi",
                width: 75.w,
                height: 28.h,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
