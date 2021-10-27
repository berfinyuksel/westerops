import 'package:dongu_mobile/data/model/box_order.dart';
import 'package:dongu_mobile/data/model/store_boxes.dart';
import 'package:dongu_mobile/data/repositories/address_repository.dart';

import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';

import 'package:dongu_mobile/presentation/screens/cart_view/not_logged_in_view.dart';

import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../past_order_detail_view/components/past_order_detail_basket_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_body_title.dart';
import '../past_order_detail_view/components/past_order_detail_payment_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_total_payment_list_tile.dart';
import 'empty_cart_view.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<String> menuList = SharedPrefs.getMenuList;
  List<BoxOrder> itemList = [];
  List<String> sumOfPricesString = SharedPrefs.getSumPrice;

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
        if (state.response.length == 0) {
          return EmptyCartView();
        } else {
          return Center(child: buildBody(context, state, itemList));
        }
      } else {
        final error = state as GenericError;

        return SharedPrefs.getIsLogined == false
            ? NotLoggedInEmptyCartView()
            : CartView(); //Center(child: Text("${error.message}\n${error.statusCode}"));

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
              top: context.dynamicHeight(0.02),
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
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
                    return Builder(builder: (context) {
                      context
                          .read<StoreBoxesCubit>()
                          .getStoreBoxes(itemList[index].id!);

                      final counterState =
                          context.watch<BasketCounterCubit>().state;
                      print(itemList[index]
                          .packageSetting
                          ?.minDiscountedOrderPrice);
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
                                    'Sepetinizdeki ürünü silmek\nistediğinize emin misiniz?',
                                buttonOneTitle: 'Vazgeç',
                                buttonTwoTittle: 'Eminim',
                                imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                                onPressedOne: () {
                                  Navigator.of(context).pop();
                                },
                                onPressedTwo: () {
                                  context.read<OrderCubit>().deleteBasket(
                                      "${state.response[index].id}");
                                  context
                                      .read<BasketCounterCubit>()
                                      .decrement();
                                  SharedPrefs.setCounter(counterState - 1);
                                  menuList.remove(
                                      state.response[index].id.toString());
                                  SharedPrefs.setMenuList(menuList);
                                  Navigator.of(context).pop();
                                }),
                          );
                        },
                        child: PastOrderDetailBasketListTile(
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
                  title: LocaleKeys.past_order_detail_payment_1,
                  price: state.toDouble(),
                  lineTrough: false,
                  withDecimal: false,
                );
              }),
              PastOrderDetailPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_2,
                price: 4.50,
                lineTrough: true,
                withDecimal: true,
              ),
              PastOrderDetailPaymentListTile(
                title: "${LocaleKeys.past_order_detail_payment_3.locale} (2)*",
                price: 0.50,
                lineTrough: false,
                withDecimal: true,
              ),
              PastOrderDetailTotalPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_4,
                price: 70.50,
                withDecimal: true,
              ),
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
        buildButton(context),
      ],
    );
  }

  Padding buildButton(BuildContext context) {
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
        itemCount: state.response.length,
        itemBuilder: (context, index) {
          if (!restaurantNames.contains(itemList[index].store!.name)) {
            restaurantNames.add(itemList[index].store!.name);
            SharedPrefs.setDeliveredRestaurantAddressId(
                itemList[index].store!.id!);

            return Builder(builder: (context) {
              final GenericState stateOfSearchStore =
                  context.watch<SearchStoreCubit>().state;
              if (stateOfSearchStore is GenericCompleted) {
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
                          stateOfSearchStore.response[index],
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
