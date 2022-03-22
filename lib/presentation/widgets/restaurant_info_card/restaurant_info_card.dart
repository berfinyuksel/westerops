import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/services/locator.dart';
import '../../../logic/cubits/box_cubit/box_state.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../restaurant_info_list_tile/first_column/packet_number.dart';
import '../restaurant_info_list_tile/first_column/restaurant_icon.dart';
import '../restaurant_info_list_tile/second_column/package_delivery.dart';
import '../restaurant_info_list_tile/third_column/available_time.dart';
import '../restaurant_info_list_tile/third_column/meters.dart';
import '../restaurant_info_list_tile/third_column/old_and_new_prices.dart';

class RestaurantInfoCard extends StatefulWidget {
  final String? packetNumber;
  final String? restaurantName;
  final String? grade;
  final String? location;
  final String? distance;
  final String? availableTime;
  final String? backgroundImage;
  final String? restaurantIcon;
  final int? minDiscountedOrderPrice;
  final int? minOrderPrice;
  final Color? getItPackageIconColor;
  final Color? getItPackageBGColor;
  final Color? courierPackageIconColor;
  final Color? courierPackageBGColor;
  final int restaurantId;
  final double? width;

  const RestaurantInfoCard({
    Key? key,
    this.packetNumber,
    required this.restaurantId,
    this.restaurantName,
    this.grade,
    this.location,
    this.distance,
    this.availableTime,
    this.backgroundImage,
    this.restaurantIcon,
    this.minDiscountedOrderPrice,
    this.minOrderPrice,
    this.courierPackageBGColor,
    this.courierPackageIconColor,
    this.getItPackageBGColor,
    this.getItPackageIconColor,
    this.width,
  }) : super(key: key);

  @override
  State<RestaurantInfoCard> createState() => _RestaurantInfoCardState();
}

class _RestaurantInfoCardState extends State<RestaurantInfoCard> {
  @override
  void initState() {
    // sl<BoxCubit>().getBoxes(widget.restaurantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BoxCubit>()..getBoxes(widget.restaurantId),
      child: Container(
        width: widget.width,
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              child: Image.network(
                widget.backgroundImage!,
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
                width: context.dynamicWidht(0.64),
                height: context.height > 800
                    ? context.dynamicHeight(0.16)
                    : context.dynamicHeight(0.14),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.dynamicHeight(0.011),
                  horizontal: context.dynamicWidht(0.023)),
              child: Column(
                children: [
                  buildFirstRow(context, widget.packetNumber!),
                  Spacer(flex: 9),
                  buildSecondRow(
                      widget.restaurantName!, widget.restaurantIcon!, context),
                  Spacer(flex: 1),
                  buildThirdRow(
                      widget.grade!, widget.location!, widget.distance!),
                  Divider(
                    thickness: 2,
                    color: AppColors.borderAndDividerColor,
                  ),
                  buildForthRow(context, widget.availableTime!)
                ],
              ),
            ),
          ],
        ),
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
          minDiscountedOrderPrice: widget.minDiscountedOrderPrice,
          minOrderPrice: widget.minOrderPrice,
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
          distance: "${(double.parse(distance) / 100000).toStringAsFixed(2)}",
        ),
      ],
    );
  }

  Row buildSecondRow(
      String restaurantName, String restaurantIcon, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RestrauntIcon(
          icon: restaurantIcon,
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Flexible(
          flex: 6,
          child: Text(
            restaurantName,
            style: AppTextStyles.bodyBoldTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Row buildFirstRow(BuildContext context, String packetNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<BoxCubit, BoxState>(
          builder: (context, state) {
            if (state is BoxLoading) {
              return CustomCircularProgressIndicator();
            } else if (state is BoxCompleted) {
              return PacketNumber(
                text: state.packages.length != 0
                    ? "${state.packages.length.toString()} paket"
                    : "tükendi",
                width: context.dynamicWidht(0.185),
                height: context.dynamicHeight(0.035),
              );
            } else {
              return SizedBox();
            }
          },
        ),
        Spacer(),
        PackageDelivery(
          image: ImageConstant.RESTAURANT_PACKAGE_ICON,
          color: widget.getItPackageIconColor,
          backgroundColor: widget.getItPackageBGColor,
          width: 43.w,
          height: 30.h,
        ),
        Container(
          margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
          child: PackageDelivery(
            image: ImageConstant.COMMONS_CARRIER_ICON,
            color: widget.courierPackageIconColor,
            backgroundColor: widget.courierPackageBGColor,
            width: 43.w,
            height: 30.h,
          ),
        ),
      ],
    );
  }
}
