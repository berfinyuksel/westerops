import '../../../data/model/order_received.dart';
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

class SwipeView extends StatefulWidget {
  final OrderReceived? orderInfo;
  const SwipeView({Key? key, this.orderInfo}) : super(key: key);

  @override
  _SwipeViewState createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  String mealNames = '';

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
                infoCard(context),
                Spacer(
                  flex: 30,
                ),
                Dismissible(
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
                  },
                  direction: DismissDirection.startToEnd,
                  child: Container(
                    //curve: Curve,
                    height: context.dynamicHeight(0.12),
                    width: context.dynamicWidht(0.9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.greenColor,
                      border: Border.all(
                        width: 2.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                    child: TextButton(
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LocaleText(
                                text: LocaleKeys.swipe_swipeButton,
                                style: AppTextStyles.bodyTitleStyle
                                    .copyWith(color: AppColors.appBarColor)),
                            SizedBox(
                              width: context.dynamicWidht(0.02),
                            ),
                            SvgPicture.asset(
                              ImageConstant.RIGHT_ICON,
                              height: 24,
                              color: AppColors.appBarColor,
                            ),
                            SvgPicture.asset(
                              ImageConstant.RIGHT_ICON,
                              height: 24,
                              color: AppColors.appBarColor,
                            ),
                            // Icon(Icons.keyboard_arrow_right),
                            // Icon(Icons.keyboard_arrow_right),
                          ],
                        )),
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

  Container infoCard(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.16),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
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
                  price: (widget.orderInfo!.cost! /
                      widget.orderInfo!.boxes!.length),
                  withDecimal: false,
                  subTitle: widget.orderInfo!.boxes![index].meals!.isEmpty
                      ? ""
                      : mealNames,
                );
              }),
          Spacer(
            flex: 40,
          ),
          Divider(
            height: context.dynamicHeight(0.001),
            thickness: 1,
          ),
          Spacer(
            flex: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleText(
                  text: LocaleKeys.swipe_totalAmount,
                  style: AppTextStyles.myInformationBodyTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Container(
                  alignment: Alignment.center,
                  width: context.dynamicWidht(0.16),
                  height: context.dynamicHeight(0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.scaffoldBackgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: context.dynamicWidht(0.01)),
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
          ),
          Spacer(
            flex: 25,
          ),
        ],
      ),
    );
  }
}
