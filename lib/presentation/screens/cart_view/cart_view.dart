import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/box_order.dart';
import '../../../data/model/search_store.dart';
import '../../../data/services/locator.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import '../../../logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../past_order_detail_view/components/past_order_detail_basket_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_body_title.dart';
import '../past_order_detail_view/components/past_order_detail_payment_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_total_payment_list_tile.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'components/delete_item_show_dialog.dart';
import 'empty_cart_view.dart';
import 'not_logged_in_view.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<String> menuList = SharedPrefs.getMenuList;
  List<BoxOrder> itemList = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (BuildContext context) => sl<OrderCubit>()..getBasket(),
        ),
      ],
      child: buildBuilder(),
    );
  }

  double totalPayPrice() {
    double totalPrice = 0;
    for (var item in itemList) {
      totalPrice =
          totalPrice + item.packageSetting!.minDiscountedOrderPrice!.toDouble();
    }
    return totalPrice;
  }

  double totalBasketPrice() {
    double totalPrice = 0;
    for (var item in itemList) {
      totalPrice = totalPrice + item.packageSetting!.minOrderPrice!.toDouble();
    }
    return totalPrice;
  }

  BlocBuilder buildBuilder() {
    return BlocBuilder<OrderCubit, GenericState>(builder: (context, state) {
      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        for (int i = 0; i < state.response.length; i++) {
          itemList.add(state.response[i]);
        }
        totalPayPrice();
        if (itemList.length == 0) {
          // context.read<SumOldPriceOrderCubit>().clearOldPrice();
          // context.read<SumPriceOrderCubit>().clearPrice();
          SharedPrefs.setOldSumPrice(0);
          return EmptyCartView();
        } else if (SharedPrefs.getIsLogined == false) {
          return NotLoggedInEmptyCartView();
        } else {
          return Center(child: buildBody(context, state, itemList));
        }
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Column buildBody(
      BuildContext context, GenericCompleted state, List<BoxOrder> itemList) {
    return Column(
      children: [
        Container(
          height: 620.h,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            children: [
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_1,
              ),
              SizedBox(
                height: 10.h,
              ),
              buildRestaurantListTile(context, state, itemList),
              SizedBox(
                height: 40.h,
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_3,
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    context
                        .read<StoreBoxesCubit>()
                        .getStoreBoxes(itemList[index].id!);
                    context
                        .read<StoreCourierCubit>()
                        .getCourierHours(itemList[index].store!.id!);
                    final counterState =
                        context.watch<BasketCounterCubit>().state;
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 50.w),
                        child: LocaleText(
                          text: LocaleKeys.my_notifications_delete_text_text,
                          style: AppTextStyles.bodyTextStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          alignment: TextAlign.end,
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) {
                        return deleteItemShowDialogBuild(
                            context, itemList, index, counterState);
                      },
                      child: PastOrderDetailBasketListTile(
                        onPressed: () {
                          deleteItemShowDialogBuild(
                              context, itemList, index, counterState);
                        },
                        oldPrice: itemList[index]
                            .packageSetting!
                            .minOrderPrice!
                            .toDouble(),
                        withMinOrderPrice: true,
                        title: "${itemList[index].textName}",
                        price: itemList[index]
                            .packageSetting!
                            .minDiscountedOrderPrice!
                            .toDouble(),
                        withDecimal: true,
                        subTitle: "",
                      ),
                    );
                  }),
              SizedBox(
                height: 40.h,
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_4,
              ),
              SizedBox(
                height: 10.h,
              ),
              PastOrderDetailPaymentListTile(
                oldPrice: true,
                oldPriceValue: totalBasketPrice(),
                title: LocaleKeys.past_order_detail_payment_1,
                price: totalPayPrice(),
                lineTrough: false,
                withDecimal: true,
              ),
              PastOrderDetailTotalPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_4,
                price: totalPayPrice(),
                withDecimal: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                child: SvgPicture.asset(ImageConstant.CARDS_COMPANY),
              ),
            ],
          ),
        ),
        Spacer(),
        buildButton(context, itemList),
      ],
    );
  }

  Future<bool?> deleteItemShowDialogBuild(BuildContext context,
      List<BoxOrder> itemList, int index, int counterState) {
    return deleteItemShowDialog(context, () {
      context.read<OrderCubit>().deleteBasket("${itemList[index].id}");
      context.read<BasketCounterCubit>().decrement();
      SharedPrefs.setCounter(counterState - 1);
      menuList.remove(itemList[index].id.toString());
      SharedPrefs.setMenuList(menuList);
      itemList.remove(itemList[index]);
      Navigator.of(context).pop();
    });
  }

  Padding buildButton(BuildContext context, List<BoxOrder> itemList) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        bottom: 30.h,
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.cart_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          SharedPrefs.setBoxIdForDeliver(itemList.last.id!);
          Navigator.pushNamed(context, RouteConstant.PAYMENTS_VIEW);
        },
      ),
    );
  }

  ListView buildRestaurantListTile(
      BuildContext context, GenericCompleted state, List<BoxOrder> itemList) {
    List<String?> restaurantNames = [];

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          if (!restaurantNames.contains(itemList[index].store!.name)) {
            restaurantNames.add(itemList[index].store!.name);
            SharedPrefs.setDeliveredRestaurantAddressId(
                itemList[index].store!.id!);

            return BlocBuilder<SearchStoreCubit, GenericState>(
                builder: (context, state) {
              // final GenericState stateOfSearchStore =
              //     context.watch<SearchStoreCubit>().state;

              if (state is GenericCompleted) {
                List<SearchStore> chosenRestaurat = [];
                for (var i = 0; i < state.response.length; i++) {
                  if (state.response[i].id == itemList[index].store!.id) {
                    chosenRestaurat.add(state.response[i]);
                  }
                }
                return ListTile(
                    contentPadding: EdgeInsets.only(
                      left: context.dynamicWidht(0.06),
                      right: context.dynamicWidht(0.06),
                    ),
                    trailing: SvgPicture.asset(
                      ImageConstant.COMMONS_FORWARD_ICON,
                    ),
                    tileColor: Colors.white,
                    title: Text(
                      "${itemList[index].store!.name}",
                      style: AppTextStyles.bodyTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteConstant.RESTAURANT_DETAIL,
                        arguments: ScreenArgumentsRestaurantDetail(
                          restaurant: chosenRestaurat[0],
                        ),
                      );
                    });
              } else if (state is GenericInitial) {
                return Container(color: Colors.white);
              } else if (state is GenericLoading) {
                return Container(
                    color: Colors.white,
                    child: CustomCircularProgressIndicator());
              } else {
                final error = state as GenericError;

                return Center(
                    child: Text("${error.message}\n${error.statusCode}"));
              }
            });
          } else
            return SizedBox(
              height: 0.h,
              width: 0.w,
            );
        });
  }
}
