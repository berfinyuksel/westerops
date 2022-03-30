import 'package:dongu_mobile/logic/cubits/order_cubit/order_cubit.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/components/custom_alert_dialog.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class PastOrderDetailBasketListTile extends StatelessWidget {
  final String? title;
  final double? price;
  final double? oldPrice;
  final String? subTitle;
  final bool? withDecimal;
  final bool? withMinOrderPrice;
  final double? leftPadding;
  final double? rightPadding;
  final void Function()? onPressed;

  const PastOrderDetailBasketListTile({
    Key? key,
    this.title,
    this.price,
    this.oldPrice,
    this.subTitle,
    this.withDecimal,
    this.withMinOrderPrice = false,
    this.leftPadding,
    this.rightPadding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06),
          ),
          trailing: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: context.dynamicWidht(0.4),
                height: context.dynamicHeight(0.03),
                child: Row(
                  children: [
                    oldPrice != null
                        ? Text(
                            '${withDecimal! ? oldPrice!.toStringAsFixed(2) : oldPrice!.toStringAsFixed(0)} TL',
                            style: AppTextStyles.bodyBoldTextStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color:
                                    AppColors.unSelectedpackageDeliveryColor),
                          )
                        : Spacer(),
                    SizedBox(width: context.dynamicWidht(0.02)),
                    Container(
                      alignment: Alignment.center,
                      width: context.dynamicWidht(0.2),
                      height: context.dynamicHeight(0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: AppColors.scaffoldBackgroundColor,
                      ),
                      child: Text(
                        '${withDecimal! ? price!.toStringAsFixed(2) : price!.toStringAsFixed(0)} TL',
                        style: AppTextStyles.bodyBoldTextStyle
                            .copyWith(color: AppColors.greenColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          tileColor: Colors.white,
          title: Text(
            title!,
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          subtitle: Text(
            subTitle!,
            style: AppTextStyles.subTitleStyle,
          ),
        ),
        Positioned(
          right: 0.05,
          top: 10,
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.delete,
                color: AppColors.orangeColor,
              )),
        ),
      ],
    );
  }

  //Future deleteBasketItem(context) {
  //  return showDialog(
  //    context: context,
  //    builder: (_) => CustomAlertDialog(
  //        textMessage: LocaleKeys.cart_box_delete_alert_dialog,
  //        buttonOneTitle: LocaleKeys.payment_payment_cancel,
  //        buttonTwoTittle: LocaleKeys.address_address_approval,
  //        imagePath: ImageConstant.SURPRISE_PACK_ALERT,
  //        onPressedOne: () {
  //          Navigator.of(context).pop();
  //        },
  //        onPressedTwo: () {
  //          context.read<SumOldPriceOrderCubit>().decrementOldPrice(
  //              itemList[index].packageSetting!.minOrderPrice!);
  //          context.read<SumPriceOrderCubit>().decrementPrice(
  //              itemList[index].packageSetting!.minDiscountedOrderPrice!);
//
  //          context.read<OrderCubit>().deleteBasket("${itemList[index].id}");
  //          context.read<BasketCounterCubit>().decrement();
  //          SharedPrefs.setCounter(counterState - 1);
  //          menuList.remove(itemList[index].id.toString());
  //          SharedPrefs.setMenuList(menuList);
  //          itemList.remove(itemList[index]);
  //          Navigator.of(context).pop();
  //        }),
  //  );
  //}
}
