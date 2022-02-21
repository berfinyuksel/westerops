import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/logic/cubits/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/repositories/update_order_repository.dart';
import '../../../data/services/locator.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import '../past_order_detail_view/components/past_order_detail_basket_list_tile.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import 'dart:math';

class SwipeView extends StatefulWidget {
  const SwipeView({Key? key, this.orderInfo}) : super(key: key);

  final IyzcoOrderCreate? orderInfo;

  @override
  _SwipeViewState createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  String mealNames = '';

  Container infoCard(BuildContext context) {
    return Container(
      // height: min(250, (70 * widget.orderInfo!.boxes!.length.toDouble())),
      // height: context.dynamicHeight(0.40),
      width: double.infinity,
      color: Colors.white,
      child: Container(
        color: Colors.white,
        height: min(context.dynamicHeight(0.27),
            (70 * widget.orderInfo!.boxes!.length.toDouble())),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.orderInfo!.boxes!.length,
            itemBuilder: (BuildContext context, index) {
              List<String> meals = [];
              if (widget.orderInfo!.boxes![index].meals!.isNotEmpty) {
                for (var i = 0;
                    i < widget.orderInfo!.boxes![index].meals!.length;
                    i++) {
                  meals.add(widget.orderInfo!.boxes![index].meals![i].name!);
                }
                mealNames = meals.join('\n');
              }
              return PastOrderDetailBasketListTile(
                title: widget.orderInfo!.boxes![index].textName,
                price:
                    (widget.orderInfo!.cost! / widget.orderInfo!.boxes!.length),
                withDecimal: false,
                subTitle: widget.orderInfo!.boxes![index].meals!.isEmpty
                    ? ""
                    : mealNames,
              );
            }),
      ),
    );
  }

  Padding buildTotalAmount(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 26.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocaleText(
            text: LocaleKeys.swipe_totalAmount,
            style: AppTextStyles.myInformationBodyTextStyle
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Container(
            alignment: Alignment.center,
            width: 87.w,
            height: 36.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: AppColors.scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: LocaleText(
                text: widget.orderInfo!.cost.toString() + ' TL',
                style: AppTextStyles.bodyBoldTextStyle.copyWith(
                  color: AppColors.greenColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  text: LocaleKeys.swipe_text1,
                  style: AppTextStyles.appBarTitleStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.orangeColor),
                ),
                Spacer(
                  flex: 4,
                ),
                LocaleText(
                  text: LocaleKeys.swipe_text2,
                  style: AppTextStyles.myInformationBodyTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                LocaleText(
                  text: widget.orderInfo!.refCode.toString(),
                  style: AppTextStyles.headlineStyle,
                ),
                Spacer(
                  flex: 6,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 10.h),
                          LocaleText(
                            text: LocaleKeys.swipe_restaurant_name,
                            style: AppTextStyles.appBarTitleStyle.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangeColor),
                          ),
                          Spacer(),
                          LocaleText(
                            text: LocaleKeys.swipe_restaurant_address,
                            style: AppTextStyles.appBarTitleStyle.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangeColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(widget.orderInfo!.boxes!.isEmpty
                              ? "BOS"
                              : widget.orderInfo!.boxes!.first.store!.name!),
                          Spacer(),
                          Text(widget.orderInfo!.boxes!.isEmpty
                              ? "BOS ADRES"
                              : widget.orderInfo!.boxes!.first.store!.address!),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 6,
                ),
                infoCard(context),
                // Spacer(
                //   flex: 20,
                // ),
                Divider(
                  height: context.dynamicHeight(0.001),
                  thickness: 1,
                ),
                SizedBox(height: 19.h),
                buildTotalAmount(context),
                Spacer(
                  flex: 30,
                ),
                Visibility(
                  visible: widget.orderInfo!.status == '1' ||
                      widget.orderInfo!.status == '2' ||
                      widget.orderInfo!.status == '9',
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (value) {
                      SharedPrefs.setOrderBar(false);

                      setState(() {
                        Navigator.pushNamed(
                            context, RouteConstant.WAS_DELIVERED_VIEW,
                            arguments: ScreenArgumentsRestaurantDetail(
                              orderInfo: widget.orderInfo,
                            ));
                      });
                      sl<UpdateOrderRepository>()
                          .updateOrderStatus(widget.orderInfo!.id!, 6);
                      context.read<OrderBarCubit>().stateOfBar(false);
                      context.read<CancelOrderCubit>().cancelOrder(false);
                    },
                    direction: DismissDirection.startToEnd,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Container(
                        //curve: Curve,
                        height: 76.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.greenColor,
                          border: Border.all(
                            width: 2.0.w,
                            color: AppColors.greenColor,
                          ),
                        ),
                        child: TextButton(
                            onPressed: null,
                            child: Container(
                              width: 325.w,
                              height: 24.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LocaleText(
                                      text: LocaleKeys.swipe_swipeButton,
                                      style: AppTextStyles.bodyTitleStyle
                                          .copyWith(
                                              color: AppColors.appBarColor)),
                                  SizedBox(width: 9.w),
                                  SvgPicture.asset(
                                    ImageConstant.RIGHT_ICON,
                                    height: 30.h,
                                    color: AppColors.appBarColor,
                                  ),
                                  SvgPicture.asset(
                                    ImageConstant.RIGHT_ICON,
                                    height: 30.h,
                                    color: AppColors.appBarColor,
                                  ),
                                  // Icon(Icons.keyboard_arrow_right),
                                  // Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
