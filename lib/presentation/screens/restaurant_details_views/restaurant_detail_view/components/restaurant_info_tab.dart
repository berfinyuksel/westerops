import 'package:dongu_mobile/presentation/screens/restaurant_details_views/restaurant_detail_view/components/custom_circular_progress.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../data/services/locator.dart';
import '../../../../../logic/cubits/box_cubit/box_cubit.dart';
import '../../../../../logic/cubits/box_cubit/box_state.dart';
import '../../../../../utils/constants/image_constant.dart';
import '../../../../../utils/locale_keys.g.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/text/locale_text.dart';

class RestaurantInfoTab extends StatefulWidget {
  final SearchStore restaurant;
  final TabController controller;

  RestaurantInfoTab({
    Key? key,
    required this.restaurant,
    required this.controller,
  }) : super(key: key);

  @override
  State<RestaurantInfoTab> createState() => _RestaurantInfoTabState();
}

class _RestaurantInfoTabState extends State<RestaurantInfoTab> {
  List<int> servicePoints = [];
  List<int> qualityPoints = [];
  List<int> mealPoints = [];
  late String avgServicePoint;
  late String avgQualityPoint;
  late String avgMealPoint;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPoints();
  }

  void getAllPoints() {
    getServicePoints();
    getQualityPoints();
    getMealPoints();
  }

  void getServicePoints() {
    for (var review in widget.restaurant.review!) {
      int servicePoint = review.servicePoint!;
      servicePoints.add(servicePoint);
    }
    int totalServicePoints = servicePoints.fold(0, (previousValue, element) => previousValue + element);
    avgServicePoint = (totalServicePoints / widget.restaurant.review!.length).toStringAsFixed(1);
  }

  void getQualityPoints() {
    for (var review in widget.restaurant.review!) {
      int qualityPoint = review.qualityPoint!;
      qualityPoints.add(qualityPoint);
    }
    int totalQualityPoints = qualityPoints.fold(0, (previousValue, element) => previousValue + element);
    avgQualityPoint = (totalQualityPoints / widget.restaurant.review!.length).toStringAsFixed(1);
  }

  void getMealPoints() {
    for (var review in widget.restaurant.review!) {
      int mealPoint = review.qualityPoint!;
      mealPoints.add(mealPoint);
    }
    // widget.restaurant.review!.forEach((review) {
    //   int mealPoint = review.qualityPoint!;
    //   mealPoints.add(mealPoint);
    // });
    int totalMealPoints = mealPoints.fold(0, (previousValue, element) => previousValue + element);
    avgMealPoint = (totalMealPoints / widget.restaurant.review!.length).toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BoxCubit>()..getBoxes(widget.restaurant.id!),
      child: Container(
        child: Expanded(
          child: TabBarView(controller: widget.controller, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                clockContainer(context),
                packageContainer(context),
                oldPriceText(),
                newPriceText(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                serviceRatingRow(context),
                qualityRatingRow(context),
                foodRatingRow(context),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Container clockContainer(BuildContext context) {
    return Container(
      width: 125.w,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(ImageConstant.COMMONS_TIME_ICON),
          Text(
            "${widget.restaurant.packageSettings!.deliveryTimeStart!}-${widget.restaurant.packageSettings!.deliveryTimeEnd}",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.yellowColor),
          ),
        ],
      ),
    );
  }

  Widget packageContainer(BuildContext context) {
    return BlocBuilder<BoxCubit, BoxState>(
      builder: (context, state) {
        if (state is BoxCompleted) {
          return state.packages.length != 0
              ? Container(
                  alignment: Alignment(0.0, -0.11),
                  width: 85.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.orangeColor,
                  ),
                  child: Text(
                    "${state.packages.length} ${LocaleKeys.restaurant_detail_packet_container_package.locale}",
                    style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  alignment: Alignment(0.0, -0.11),
                  width: 85.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.yellowColor,
                  ),
                  child: Text(
                    LocaleKeys.restaurant_detail_packet_container_sold_out.locale,
                    style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
                  ),
                );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Text oldPriceText() {
    return Text(
      widget.restaurant.packageSettings!.minOrderPrice.toString() + " TL",
      style: AppTextStyles.bodyBoldTextStyle
          .copyWith(decoration: TextDecoration.lineThrough, color: AppColors.unSelectedpackageDeliveryColor),
    );
  }

  Container newPriceText(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -0.11),
      width: context.dynamicWidht(0.16),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Text(
        widget.restaurant.packageSettings!.minDiscountedOrderPrice.toString() + " TL",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyBoldTextStyle.copyWith(fontWeight: FontWeight.w700, color: AppColors.greenColor),
      ),
    );
  }

  Row serviceRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item1,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          value: servicePoints.isNotEmpty ? double.parse(avgServicePoint) / 5 : 0.0,
          valueColor: AppColors.greenColor,
          ratingText: servicePoints.isNotEmpty ? avgServicePoint : '0.0',
        ),
      ],
    );
  }

  Row qualityRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item2,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          valueColor: AppColors.pinkColor,
          ratingText: qualityPoints.isNotEmpty ? avgQualityPoint : '0.0',
          value: qualityPoints.isNotEmpty ? double.parse(avgQualityPoint) / 5 : 0.0,
        ),
      ],
    );
  }

  Row foodRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item3,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          valueColor: AppColors.cursorColor,
          ratingText: mealPoints.isNotEmpty ? avgMealPoint : '0.0',
          value: mealPoints.isNotEmpty ? double.parse(avgMealPoint) / 5.0 : 0.0,
        )
        /*SvgPicture.asset(ImageConstant.RESTAURANT_FOOD_RATING_ICON),*/
      ],
    );
  }
}
