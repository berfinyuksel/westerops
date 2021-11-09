import 'package:date_time_format/date_time_format.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/model/store_courier_hours.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import '../../../widgets/warning_container/warning_container.dart';
import 'components/delivery_available_time_list_tile.dart';
import 'components/delivery_custom_button.dart';

class PaymentDeliveryView extends StatefulWidget {
  final bool? isGetIt;

  const PaymentDeliveryView({Key? key, this.isGetIt}) : super(key: key);

  @override
  _PaymentDeliveryViewState createState() => _PaymentDeliveryViewState();
}

class _PaymentDeliveryViewState extends State<PaymentDeliveryView> {
  int selectedIndex = 100;
  List<StoreCourierHours>? chosenRestaurantList;
  int deliveryType = 0;
  bool selectedGetit = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        DeliveryAvailableTimeListTile(
            chosenRestaurantList: chosenRestaurantList),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: Builder(builder: (context) {
            final state = context.watch<StoreCourierCubit>().state;

            if (state is GenericInitial) {
              return Container();
            } else if (state is GenericLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GenericCompleted) {
              List<StoreCourierHours> list = [];

              for (int i = 0; i < state.response.length; i++) {
                list.add(state.response[i]);
              }
              chosenRestaurantList = list;
              print(list.length);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleText(
                    text: "Today - " +
                        DateTime.now()
                            .format(EuropeanDateFormats.standard)
                            .toString(),
                    style: AppTextStyles.bodyTitleStyle,
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.01),
                  ),
                  Visibility(
                    visible: widget.isGetIt!,
                    child: Column(
                      children: [
                        Builder(builder: (context) {
                          final GenericState stateOfRestaurants =
                              context.watch<SearchStoreCubit>().state;

                          if (stateOfRestaurants is GenericInitial) {
                            return Container();
                          } else if (stateOfRestaurants is GenericLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (stateOfRestaurants is GenericCompleted) {
                            List<SearchStore> restaurants = [];
                            List<SearchStore> chosenRestaurant = [];

                            for (int i = 0;
                                i < stateOfRestaurants.response.length;
                                i++) {
                              restaurants.add(stateOfRestaurants.response[i]);
                            }
                            for (var i = 0; i < restaurants.length; i++) {
                              if (list[0].storeId == restaurants[i].id) {
                                chosenRestaurant.add(restaurants[i]);
                              }
                            }

                            return DeliveryCustomButton(
                              onPressed: () {
                                setState(() {
                                  String timeInterval =
                                      "${chosenRestaurant[0].packageSettings!.deliveryTimeStart} - ${chosenRestaurant[0].packageSettings!.deliveryTimeEnd}";
                                  SharedPrefs.setTimeIntervalForGetIt(
                                      timeInterval);
                                  SharedPrefs.setCountDownString(
                                      chosenRestaurant[0]
                                          .packageSettings!
                                          .deliveryTimeEnd!);
                                  selectedGetit = !selectedGetit;
                                  deliveryType = 1;
                                  SharedPrefs.setDeliveryType(deliveryType);
                                });
                              },
                              width: double.infinity,
                              title:
                                  "${chosenRestaurant[0].packageSettings!.deliveryTimeStart} - ${chosenRestaurant[0].packageSettings!.deliveryTimeEnd}",
                              color: selectedGetit == true
                                  ? AppColors.greenColor.withOpacity(0.4)
                                  : Colors.white,
                            );
                          } else {
                            final error = stateOfRestaurants as GenericError;
                            return Center(
                                child: Text(
                                    "${error.message}\n${error.statusCode}"));
                          }
                        }),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        WarningContainer(
                          text:
                              "Ödemenizi size iletmiş olduğumuz\nsipariş numarasını restorana\ngöstererek yapınız.",
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                      ],
                    ),
                  ),
                  buildAvailableDeliveryTimes(context, list),
                  /*     SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  WarningContainer(
                    text:
                        "Belirtilen saat içerisinde \nrestorandan paketinizi 1 saat içinde \nalmadığınız durumda siparişiniz \niptal edilip tekrar satışa sunulacaktır.",
                  ), */
                ],
              );
            } else {
              final error = state as GenericError;
              return Center(
                  child: Text("${error.message}\n${error.statusCode}"));
            }
          }),
        ),
      ],
    );
  }

  Visibility buildAvailableDeliveryTimes(
      BuildContext context, List<StoreCourierHours> list) {
    return Visibility(
      visible: !widget.isGetIt!,
      child: list.length != 0
          ? Builder(builder: (context) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      context.dynamicWidht(0.4) / context.dynamicHeight(0.05),
                  crossAxisSpacing: context.dynamicWidht(0.046),
                  mainAxisSpacing: context.dynamicHeight(0.02),
                ),
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print(list[index].endDate);
                  return DeliveryCustomButton(
                    width: context.dynamicWidht(0.4),
                    title:
                        "${list[index].startDate!.format("H:i")} - ${list[index].endDate!.format("H:i")}",
                    color: list[index].isAvailable == true
                        ? selectedIndex == index
                            ? AppColors.greenColor.withOpacity(0.4)
                            : Colors.white
                        : Color(0xFFE4E4E4).withOpacity(0.7),
                    onPressed: list[index].isAvailable == true
                        ? () {
                            setState(() {});
                            SharedPrefs.setCountDownString(
                                list[index].endDate!.format("H:i"));
                            deliveryType = 2;
                            selectedIndex = index;
                            SharedPrefs.setCourierHourId(
                                list[selectedIndex].id!);
                            SharedPrefs.setDeliveryType(deliveryType);
                          }
                        : null,
                  );
                },
              );
            })
          : Text("Kurye uygun değildir"),
    );
  }

/*   buildDeliveryButtons(BuildContext context) {
    List<Widget> buttons = [];
    int hourLeft = 18;
    int hourRight = 18;

    for (int i = 0; i < 6; i++) {
      buttons.add(
        DeliveryCustomButton(
          width: context.dynamicWidht(0.4),
          title:
              "$hourLeft:${i % 2 == 1 ? "30" : "00"} - $hourRight:${i % 2 == 1 ? "00" : "30"}",
          color: selectedIndex == i
              ? AppColors.greenColor.withOpacity(0.4)
              : Color(0xFFE4E4E4).withOpacity(0.7),
          onPressed: () {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      hourLeft = hourLeft + (i % 2 == 1 ? 1 : 0);
      hourRight = hourRight + (i % 2 == 0 ? 1 : 0);
    }

    return buttons;
  } */
}
