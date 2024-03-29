// ignore_for_file: unnecessary_type_check

import 'dart:async';

import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/repositories/update_order_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/home_page/home_page_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/near_me_restaurant_list.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/opportunity_restaurant_list_view_widget.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/timer_countdown.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import '../my_favorites_view/components/address_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../search_view/components/horizontal_list_category_bar.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late Timer timer;
  int? durationFinal;

  int? duration;
  String mealNames = "";

  bool visible = true;
  TextEditingController? controller = TextEditingController();
  List<SearchStore> names = [];
  List<SearchStore> filteredNames = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: sl<HomePageCubit>()..init(controller!)),
          BlocProvider.value(value: sl<OrderReceivedCubit>()),
          BlocProvider.value(
              value: sl<SearchCubit>()..getSearches(controller!.text)),
        ],
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading) {
              print("HOME PAGE LOADING");
              return Center(child: CustomCircularProgressIndicator());
            } else {
              return !visible
                  ? searchListView(context, sl<SearchStoreCubit>().searchStores)
                  : WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: Center(
                          child: buildBody(
                              context, sl<SearchStoreCubit>().searchStores)));
            }
          },
        ));
  }

  Column searchListView(BuildContext context, List<SearchStore> restaurants) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28.w, 15.h, 28.w, 0.h),
          child: Row(
            children: [
              buildSearchBar(context),
              SizedBox(width: 16.w),
              visible
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                      },
                      child:
                          SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON))
                  : controller!.text.length == 0
                      ? SizedBox()
                      : searchCancelTextButton(context),
            ],
          ),
        ),
        Visibility(
          visible: !context.read<HomePageCubit>().isCancelVisible,
          child: TextButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: Text(
                "Geri Dön",
                style: AppTextStyles.bodyTextStyle,
              )),
        ),
        SizedBox(height: 20.h),
        buildBuilderSearch(context, restaurants),
      ],
    );
  }

  Widget buildBuilderSearch(
      BuildContext context, List<SearchStore> restaurants) {
    return BlocBuilder<SearchCubit, GenericState>(builder: (context, state) {
      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Container(
            color: Colors.transparent,
            child: Center(child: CustomCircularProgressIndicator()));
      } else if (state is GenericCompleted) {
        List<SearchStore> searchList = [];
        List<SearchStore> restaurant = [];
        for (int i = 0; i < state.response.length; i++) {
          searchList.add(state.response[i]);
          if (state is GenericCompleted) {
            restaurant.add(state.response[i]);
          }
        }
        names = searchList;
        filteredNames = names;

        return Center(
            child: filteredNames.length == 0
                ? emptySearchHistory()
                : searchListViewBuilder(state, searchList, restaurant));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  GestureDetector buildBody(
      BuildContext context, List<SearchStore> restaurants) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        children: [
          Visibility(
              visible: context.watch<OrderBarCubit>().state,
              child: buildOrderStatusBar()),
          SizedBox(height: 20.h),
          buildRowTitleLeftRightLocation(context, LocaleKeys.home_page_location,
              LocaleKeys.home_page_edit),
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: AddressText(),
          ),
          SizedBox(height: 30.h),
          buildSearchBarAndFilterIcon(context),
          SizedBox(height: 30.h),
          visible ? SizedBox() : buildBuilderSearch(context, restaurants),
          buildRowTitleLeftRightNearMeAll(context, LocaleKeys.home_page_closer,
              LocaleKeys.home_page_see_all),
          buildDivider(),
          SizedBox(height: 22.h),
          buildListViewNearMe(context, restaurants),
          SizedBox(height: 40.h),
          buildCategoriesText(),
          buildDivider(),
          SizedBox(height: 15.h),
          buildCategories(),
          SizedBox(height: 40.h),
          buildOpportunitiesText(),
          buildDivider(),
          SizedBox(height: 10.h),
          buildListViewOpportunities(context, restaurants),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Padding buildOpportunitiesText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: LocaleText(
        text: LocaleKeys.home_page_opportunities,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Container buildCategories() {
    return Container(
      height: 150.h,
      child: CustomHorizontalListCategory(),
    );
  }

  Padding buildCategoriesText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: LocaleText(
        text: LocaleKeys.home_page_categories,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Padding buildSearchBarAndFilterIcon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageCancelState) {}
          return Column(
            children: [
              Row(
                children: [
                  buildSearchBar(context),
                  SizedBox(width: 16.w),
                  visible
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstant.FILTER_VIEW);
                          },
                          child: SvgPicture.asset(
                              ImageConstant.COMMONS_FILTER_ICON))
                      : context.read<HomePageCubit>().isCancelVisible
                          ? searchCancelTextButton(context)
                          : SizedBox(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 26.w),
      child: Divider(
        thickness: 4,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }

  Widget buildOrderStatusBar() {
    return BlocBuilder<OrderReceivedCubit, GenericState>(
        builder: (context, state) {
      if (state is GenericInitial) {
        print("INITIAL STATUS BAR");

        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        print("LOADING STATUS BAR");

        return Container(
            color: Colors.white,
            child: Center(child: CustomCircularProgressIndicator()));
      } else if (state is GenericCompleted) {
        print("COMPLETED STATUS BAR");
        List<IyzcoOrderCreate> orderInfoTotal = [];
        List<IyzcoOrderCreate> orderInfo = [];

        for (var i = 0; i < state.response.length; i++) {
          orderInfoTotal.add(state.response[i]);
        }
        for (var i = 0; i < orderInfoTotal.length; i++) {
          if (SharedPrefs.getOrderRefCode == orderInfoTotal[i].refCode) {
            orderInfo.add(orderInfoTotal[i]);
          }
        }
        //print("GET CANCEL STATUS: ${sl<UpdateOrderRepository>().getCancelStatus}");
        return orderInfo.isNotEmpty && SharedPrefs.getIsDeleteOrder == false
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                          arguments: ScreenArgumentsRestaurantDetail(
                            orderInfo: orderInfo.first,
                          ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 93.h,
                  color: AppColors.greenColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LocaleText(
                            text: LocaleKeys.home_page_active_order,
                            style: AppTextStyles.subTitleBoldStyle,
                          ),
                          Text(
                            '${orderInfo.first.address!.name} - ${orderInfo.first.buyingTime!.toLocal().day}.${orderInfo.first.buyingTime!.toLocal().month}.${orderInfo.first.buyingTime!.toLocal().year}',
                            style: AppTextStyles.subTitleBoldStyle,
                          ),
                          Text(
                            orderInfo.first.boxes!.isNotEmpty
                                ? orderInfo.first.boxes![0].store!.name
                                    .toString()
                                : '',
                            style: AppTextStyles.bodyBoldTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: orderInfo.first.boxes!.isNotEmpty,
                        child: countdown(orderInfo),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(left: context.dynamicWidht(0.01)),
                        width: 69.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.scaffoldBackgroundColor,
                        ),
                        child: Text(
                          '${orderInfo.first.cost} TL',
                          style: AppTextStyles.bodyBoldTextStyle
                              .copyWith(color: AppColors.greenColor),
                        ),
                      ),
                      SvgPicture.asset(
                        ImageConstant.COMMONS_FORWARD_ICON,
                        fit: BoxFit.fitWidth,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(height: 0.h, width: 0.w);
      } else {
        final error = state as GenericError;
        if (error.statusCode == "400") {
          context.read<OrderBarCubit>().stateOfBar(false);
          SharedPrefs.setOrderBar(false);
          return SizedBox();
        }
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Container buildListViewNearMe(
      BuildContext context, List<SearchStore> restaurants) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: 265.h,
      child: NearMeRestaurantListViewWidget(
          controller: sl<HomePageCubit>().nearMeScrollController,
          restaurants: restaurants),
    );
  }

  Container buildListViewOpportunities(
    BuildContext context,
    List<SearchStore> restaurants,
  ) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: 265.h,
      child: OpportunityRestaurantListViewWidget(
          restaurants: restaurants,
          controller: sl<HomePageCubit>().opportunitiesScrollController),
    );
  }

  Padding buildRowTitleLeftRightLocation(
      BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.ADDRESS_VIEW);
            },
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 14.0.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
                height: 2.0.h,
              ),
              alignment: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRowTitleLeftRightNearMeAll(
      BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.MY_NEAR_VIEW);
            },
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
                height: 2.0.h,
              ),
              alignment: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildSearchBar(BuildContext context) {
    return Expanded(
      child: Container(
        width: visible ? 308.w : 270.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(25.0),
            left: Radius.circular(4.0),
          ),
          color: Colors.white,
        ),
        child: TextFormField(
          autofocus: !visible,
          cursorColor: AppColors.cursorColor,
          style: AppTextStyles.bodyTextStyle,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  context
                      .read<SearchStoreCubit>()
                      .getSearches(controller!.text);
                },
                child: SvgPicture.asset(
                  ImageConstant.COMMONS_SEARCH_ICON,
                ),
              ),
              border: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
              enabledBorder: buildOutlineInputBorder(),
              errorBorder: buildOutlineInputBorder(),
              disabledBorder: buildOutlineInputBorder(),
              contentPadding:
                  EdgeInsets.only(left: context.dynamicWidht(0.040)),
              hintText: LocaleKeys.my_near_hint_text.locale),
          inputFormatters: [
            //  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          onChanged: (value) {
            context.read<SearchCubit>().getSearches(controller!.text);
          },
          onTap: () {
            setState(() {
              if (visible) {
                visible = !visible;
              }
            });
          },
          controller: controller,
        ),
      ),
    );
  }

  emptySearchHistory() {
    return Container(
      color: Colors.transparent,
      height: 50.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: LocaleText(
            text: "Aradığınız isimde bir yemek bulunmamaktadır.",
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.cursorColor)),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25.0),
        left: Radius.circular(4.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }

  List<int> buildTimeNow() {
    String timeNow = DateTime.now().toIso8601String();
    List<String> timeNowList = timeNow.split("T").toList();
    List<String> timeNowHourList = timeNowList[1].split(".").toList();
    List<String> timeNowComponentsList = timeNowHourList[0].split(":").toList();
    List<int> timeNowHourComponentList = [];

    timeNowComponentsList.forEach((e) {
      timeNowHourComponentList.add(int.parse(e));
    });
    return timeNowHourComponentList;
  }

  Widget countdown(List<IyzcoOrderCreate> orderInfo) {
    List<int> itemsOfCountDown = buildDurationForCountdown(
        DateTime.now(),
        orderInfo.first.boxes!.isNotEmpty
            ? orderInfo.first.boxes!.first.saleDay!.endDate!.toLocal()
            : orderInfo.first.buyingTime!.toLocal());
    int hour = itemsOfCountDown[0];
    int minute = itemsOfCountDown[1];
    int second = itemsOfCountDown[2];
    return TimerCountDown(
        hour: hour,
        minute: minute,
        second: second,
        textStyle:
            AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white));
  }

  List<int> buildDurationForCountdown(DateTime dateTime, DateTime local) {
    List<int> results = [];
    int durationOfNow = buildDurationSecondsForDateTimes(dateTime);
    int durationOfEnd = buildDurationSecondsForDateTimes(local);

    durationFinal = durationOfEnd - durationOfNow;
    int hourOfitem = (durationFinal! ~/ (60 * 60));
    results.add(hourOfitem);
    int minuteOfitem = (durationFinal! - (hourOfitem * 60 * 60)) ~/ 60;
    results.add(minuteOfitem);

    int secondOfitem =
        (durationFinal! - (minuteOfitem * 60) - (hourOfitem * 60 * 60));
    results.add(secondOfitem);

    return results;
  }

  int buildDurationSecondsForDateTimes(DateTime dateTime) {
    int hourOfItem = dateTime.hour;
    int minuteOfitem = dateTime.minute;
    int secondsOfitem = dateTime.second;
    int durationOfitems =
        ((hourOfItem * 60 * 60) + (minuteOfitem * 60) + (secondsOfitem));
    return durationOfitems;
  }

  ListView searchListViewBuilder(
    GenericState stateSearch,
    List<SearchStore> searchList,
    List<SearchStore> restaurants,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchList.isEmpty ||
                controller!.text.isEmpty ||
                filteredNames.isEmpty
            ? 0
            : searchList.length,
        itemBuilder: (context, index) {
          List<String> meals = [];

          if (filteredNames[index].storeMeals == null) {
            return Text("Aradığınız isimde bir yemek bulunmamaktadır.");
          } else if (filteredNames[index].storeMeals != null) {
            for (var i = 0; i < filteredNames[index].storeMeals!.length; i++) {
              meals.add(filteredNames[index].storeMeals![i].name!);
            }
            mealNames = meals.join(', ');
          }

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                    restaurant: restaurants[index],
                  ),
                );
              },
              title: Text(searchList.isEmpty ||
                      filteredNames.isEmpty ||
                      "${filteredNames[index].name}".isEmpty
                  ? ""
                  : "${filteredNames[index].name}"),
              subtitle: Text(mealNames.isEmpty ||
                      searchList.isEmpty ||
                      filteredNames.isEmpty
                  ? ""
                  : mealNames),
            ),
          );
        });
  }

  TextButton searchCancelTextButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          setState(() {
            visible = !visible;
            Future.delayed(Duration(milliseconds: 100), () {
              FocusScope.of(context).unfocus();
            });
            controller!.clear();
          });
        },
        child: Text(
          LocaleKeys.search_cancel_button.locale,
          style: AppTextStyles.bodyTitleStyle
              .copyWith(color: AppColors.orangeColor, fontSize: 12.sp),
        ));
  }
}
