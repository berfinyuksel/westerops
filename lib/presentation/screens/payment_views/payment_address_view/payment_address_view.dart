import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/model/search_store.dart';
import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';
import '../../address_view/components/adress_list_tile.dart';
import 'components/get_it_address_list_tile.dart';

class PaymentAddressView extends StatefulWidget {
  final bool? isGetIt;

  const PaymentAddressView({Key? key, this.isGetIt}) : super(key: key);

  @override
  _PaymentAddressViewState createState() => _PaymentAddressViewState();
}

class _PaymentAddressViewState extends State<PaymentAddressView> {
  bool checkboxValue = false;
  @override
  void initState() {
    super.initState();
    context.read<SearchStoreCubit>().getSearchStore();
    context.read<AddressCubit>().getActiveAddress();
  }

  @override
  Widget build(BuildContext context) {
    final GenericState state = context.watch<SearchStoreCubit>().state;

    if (state is GenericInitial) {
      return Container();
    } else if (state is GenericLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is GenericCompleted) {
      List<SearchStore> restaurants = [];
      List<SearchStore> deliveredRestaurant = [];
      int? restaurantId = SharedPrefs.getDeliveredRestaurantAddressId;
      print(state.response);
      for (int i = 0; i < state.response.length; i++) {
        restaurants.add(state.response[i]);
      }

      for (var i = 0; i < restaurants.length; i++) {
        if (restaurants[i].id == restaurantId) {
          deliveredRestaurant.add(restaurants[i]);
        }
      }
      print(deliveredRestaurant);
      return Center(
        child: buildBody(context, deliveredRestaurant),
      );
    } else {
      final error = state as GenericError;
      return Center(child: Text("${error.message}\n${error.statusCode}"));
    }
  }

  Builder buildBody(
      BuildContext context, List<SearchStore> deliveredRestaurant) {
    return Builder(builder: (context) {
      final GenericState activeAddressState =
          context.watch<AddressCubit>().state;

      if (activeAddressState is GenericCompleted) {
        if (deliveredRestaurant.isEmpty) {
          return Text("Restoran adresi bulunamadı");
        } else
          return Container(
            height: context.dynamicHeight(0.57),
            child: ListView(
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.04),
                ),
                buildRowTitleLeftRight(
                    context,
                    widget.isGetIt!
                        ? LocaleKeys.payment_address_from_address
                        : LocaleKeys.payment_address_to_address,
                    widget.isGetIt!
                        ? LocaleKeys.payment_address_show_on_map
                        : LocaleKeys.payment_address_change),
                SizedBox(
                  height: context.dynamicHeight(0.01),
                ),
                Visibility(
                  visible: widget.isGetIt!,
                  child: GetItAddressListTile(
                    userAddress:
                        '${deliveredRestaurant[0].address} ${deliveredRestaurant[0].province}',
                    userAddressName: deliveredRestaurant[0].name,
                    restaurantName: deliveredRestaurant[0].name,
                    address:
                        '${deliveredRestaurant[0].address} ${deliveredRestaurant[0].province}',
                  ),
                ),
                Visibility(
                  visible: !widget.isGetIt!,
                  child: Column(children: [
                    AddressListTile(
                      title: activeAddressState.response[0].name,
                      subtitleBold: activeAddressState.response[0].province,
                      address:
                          "\n${activeAddressState.response[0].address}\n${activeAddressState.response[0].phoneNumber}\n${activeAddressState.response[0].description}",
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                    buildButtonDeliveryAndBillingAddress(
                        context, LocaleKeys.payment_address_button_add_address),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                    buildRowCheckBox(context),
                  ]),
                ),
/*           SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            buildRowTitleLeftRight(context, LocaleKeys.payment_address_billing_info, LocaleKeys.payment_address_change),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            AddressListTile(
              title: "Ev\t\t",
              subtitleBold: "Beşiktaş (Kuruçeşme, Muallim Cad.)\t\t",
              subtitle: "\njonh.doe@mail.com\t\t\nLorem Ipsum Dolor sit amet No:5 D:5\t\t\n+90 555 555 55 55\t\t\nSüpermarketin üstü\t\t", 
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            buildButtonDeliveryAndBillingAddress(context, LocaleKeys.payment_address_button_add_bill),
               SizedBox(
              height: context.dynamicHeight(0.02),
            ), */
              ],
            ),
          );
      } else if (activeAddressState is GenericInitial) {
        return Container();
      } else if (activeAddressState is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        print('wwwwalalalalalal');
        final error = activeAddressState as GenericError;
        print(error.message);
        if (error.statusCode == 204.toString()) {
          return Column(
            children: [
              SizedBox(height: 20),
              LocaleText(
                text: "Aktif adres belirleyiniz",
              ),
            ],
          );
        }
        print(error.statusCode);

        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Padding buildRowCheckBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          buildCheckBox(context),
          SizedBox(width: context.dynamicWidht(0.02)),
          LocaleText(
            text: LocaleKeys.payment_address_use_as_billing,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Padding buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {},
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildButtonDeliveryAndBillingAddress(
      BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: title,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteConstant.ADDRESS_VIEW);
        },
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.04),
      width: context.dynamicWidht(0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.transparent,
          value: checkboxValue,
          onChanged: (value) {
            setState(() {
              checkboxValue = value!;
            });
          },
        ),
      ),
    );
  }
}
