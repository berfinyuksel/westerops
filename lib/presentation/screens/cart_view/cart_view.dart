import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/box_order.dart';
import '../../../data/model/search_store.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import '../../../logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import '../../../logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
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
import '../surprise_pack_view/components/custom_alert_dialog.dart';
import 'empty_cart_view.dart';
import 'not_logged_in_view.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<String> menuList = SharedPrefs.getMenuList;
  List<BoxOrder> itemList = [];
  List<String> sumOfPricesString = SharedPrefs.getSumPrice;
  List<int> sumOfPricesInt = [];
  List<int> sumOfOldPrices = [];
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getBasket();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<OrderCubit>().state;
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        for (int i = 0; i < state.response.length; i++) {
          itemList.add(state.response[i]);
        }
        if (itemList.length == 0) {
          return EmptyCartView();
        } else if ( SharedPrefs.getIsLogined == false) {
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
          height: context.dynamicHeight(0.66),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: context.dynamicHeight(0.02)
            ),
            children: [
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_1,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              buildRestaurantListTile(context, state, itemList),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_3,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Builder(builder: (context) {
                      context
                          .read<StoreBoxesCubit>()
                          .getStoreBoxes(itemList[index].id!);
                      context
                          .read<StoreCourierCubit>()
                          .getCourierHours(itemList[index].store!.id!);
                      final counterState =
                          context.watch<BasketCounterCubit>().state;
                      sumOfOldPrices
                          .add(itemList[index].packageSetting!.minOrderPrice!);
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        background: Container(
                          color: AppColors.redColor,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                              right: context.dynamicWidht(0.06)),
                          child: LocaleText(
                            text: LocaleKeys.my_notifications_delete_text_text,
                            style: AppTextStyles.bodyTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            alignment: TextAlign.end,
                          ),
                        ),
                        confirmDismiss: (DismissDirection direction) {
                          return showDialog(
                            context: context,
                            builder: (_) => CustomAlertDialog(
                                textMessage:
                                    LocaleKeys.cart_box_delete_alert_dialog,
                                buttonOneTitle:
                                    LocaleKeys.payment_payment_cancel,
                                buttonTwoTittle:
                                    LocaleKeys.address_address_approval,
                                imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                                onPressedOne: () {
                                  Navigator.of(context).pop();
                                },
                                onPressedTwo: () {
                                  sumOfPricesString.remove(itemList[index]
                                      .packageSetting!
                                      .minDiscountedOrderPrice!
                                      .toString());
                                  SharedPrefs.setSumPrice(sumOfPricesString);
                                  for (var i = 0;
                                      i < sumOfPricesString.length;
                                      i++) {
                                    sumOfPricesInt
                                        .add(int.parse(sumOfPricesString[i]));
                                  }
                                  context
                                      .read<SumPriceOrderCubit>()
                                      .sumprice(sumOfPricesInt);

                                  context.read<OrderCubit>().deleteBasket(
                                      "${itemList[index].id}");
                                  context
                                      .read<BasketCounterCubit>()
                                      .decrement();
                                  SharedPrefs.setCounter(counterState - 1);
                                  menuList.remove(
                                    itemList[index].id.toString());
                                  SharedPrefs.setMenuList(menuList);
                                  itemList.remove(itemList[index]);
                                  Navigator.of(context).pop();
                                }),
                          );
                        },
                        child: PastOrderDetailBasketListTile(
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
                          withDecimal: false,
                          subTitle: "",
                        ),
                      );
                    });
                  }),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_4,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              Builder(builder: (context) {
                final state = context.watch<SumPriceOrderCubit>().state;

                return PastOrderDetailPaymentListTile(
                  oldPrice: sumOfOldPrices.fold(
                      0, (previous, current) => previous! + current),
                  title: LocaleKeys.past_order_detail_payment_1,
                  price: state.toDouble(),
                  lineTrough: false,
                  withDecimal: false,
                );
              }),
              Builder(builder: (context) {
                final state = context.watch<SumPriceOrderCubit>().state;

                return PastOrderDetailTotalPaymentListTile(
                  title: LocaleKeys.past_order_detail_payment_4,
                  price: (state.toDouble()),
                  withDecimal: true,
                );
              }),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065),
                    vertical: context.dynamicHeight(0.02)),
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

  Padding buildButton(BuildContext context, List<BoxOrder> itemList) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
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

            return Builder(builder: (context) {
              final GenericState stateOfSearchStore =
                  context.watch<SearchStoreCubit>().state;

              if (stateOfSearchStore is GenericCompleted) {
                List<SearchStore> chosenRestaurat = [];
                for (var i = 0; i < stateOfSearchStore.response.length; i++) {
                  if (stateOfSearchStore.response[i].id ==
                      itemList[index].store!.id) {
                    chosenRestaurat.add(stateOfSearchStore.response[i]);
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
                    title: LocaleText(
                      text: "${itemList[index].store!.name}",
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
              } else if (stateOfSearchStore is GenericInitial) {
                return Container();
              } else if (stateOfSearchStore is GenericLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                final error = stateOfSearchStore as GenericError;

                return Center(
                    child: Text("${error.message}\n${error.statusCode}"));
              }
            });
          } else
            return SizedBox(
              height: 0,
              width: 0,
            );
        });
  }
}
