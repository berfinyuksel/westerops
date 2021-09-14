
import 'package:dongu_mobile/data/model/store.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/store_cubit/store_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_card/restaurant_info_card.dart';
import '../../widgets/text/locale_text.dart';
import '../my_favorites_view/components/address_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../search_view/components/horizontal_list_category_bar.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool scroolNearMe = false;
  bool scroolCategories = false;
  bool scroolOpportunities = false;
  ScrollController? _controller;
  @override
  void initState() {
    super.initState();
    context.read<StoreCubit>().getStores();
    LocationService.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<StoreCubit>().state;
      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<Store> restaurants = [];
        List<double> distances = [];
        print(state.response[0].address);
        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }

        return Center(child: buildBody(context, restaurants, distances, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  ListView buildBody(BuildContext context, List<Store> restaurants,
      List<double> distances, GenericCompleted state) {
    return ListView(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
        bottom: context.dynamicHeight(0.02),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: buildRowTitleLeftRightLocation(context,
              LocaleKeys.home_page_location, LocaleKeys.home_page_edit),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
          ),
          child: Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: AddressText(),
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: Row(
            children: [
              buildSearchBar(context),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                  },
                  child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
            ],
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: buildRowTitleLeftRightNearMeAll(context,
              LocaleKeys.home_page_closer, LocaleKeys.home_page_see_all),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
          ),
          child: Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.02)),
        //bool scrool = false;
        Padding(
          padding: scroolNearMe
              ? EdgeInsets.only(
                  left: context.dynamicWidht(0.02),
                  right: context.dynamicWidht(0.02),
                )
              : EdgeInsets.only(
                  left: context.dynamicWidht(0.06),
                  right: context.dynamicWidht(0.06),
                ),
          child: buildListViewNearMe(context, restaurants, distances, state),
        ),
        SizedBox(height: context.dynamicHeight(0.04)),
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: LocaleText(
            text: LocaleKeys.home_page_categories,
            style: AppTextStyles.bodyTitleStyle,
          ),
        ),
        Padding(
          // scroll edildiğinde 0 olacak
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
          ),
          child: Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        Padding(
          padding: scroolCategories
              ? EdgeInsets.only(
                  left: context.dynamicWidht(0.02),
                  right: context.dynamicWidht(0.02),
                )
              : EdgeInsets.only(
                  left: context.dynamicWidht(0.06),
                  right: context.dynamicWidht(0.06),
                ),
          child: Container(
              height: context.dynamicHeight(0.16),
              child: NotificationListener(
                  onNotification: (t) {
                    if (scroolCategories == false) {
                      setState(() {
                        scroolCategories = !scroolCategories;
                      });
                    }
                    return scroolCategories;
                  },
                  child: CustomHorizontalListCategory())),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06)),
          child: LocaleText(
            text: LocaleKeys.home_page_opportunities,
            style: AppTextStyles.bodyTitleStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
          ),
          child: Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        Padding(
          padding: scroolOpportunities
              ? EdgeInsets.only(
                  left: context.dynamicWidht(0.02),
                  right: context.dynamicWidht(0.02),
                )
              : EdgeInsets.only(
                  left: context.dynamicWidht(0.06),
                  right: context.dynamicWidht(0.06),
                ),
          child: buildListViewOpportunities(context, restaurants, distances),
        ),
      ],
    );
  }

  Container buildListViewNearMe(BuildContext context, List<Store> restaurants,
      List<double> distances, GenericCompleted state) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: NotificationListener(
        onNotification: (t) {
          if (scroolNearMe == false) {
            setState(() {
              scroolNearMe = !scroolNearMe;
            });
          }

          return scroolNearMe;
        },
        child: ListView.separated(
          controller: _controller,
          itemCount: restaurants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurants[index],
                    ));
              },
              child: RestaurantInfoCard(
                restaurantIcon: restaurants[index].photo,
                backgroundImage: restaurants[index].background,
                packetNumber: "${restaurants[index].id} paket",
                restaurantName: restaurants[index].name,
                grade: "1",
                location: restaurants[index].city,
                distance: restaurants[index].latitude.toString(),
                availableTime: '1-4',
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        ),
      ),
    );
  }

  Container buildListViewOpportunities(
      BuildContext context, List<Store> restaurants, List<double> distances) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: NotificationListener(
        onNotification: (t) {
          if (scroolOpportunities == false) {
            setState(() {
              scroolOpportunities = !scroolOpportunities;
            });
          }
          return scroolOpportunities;
        },
        child: ListView.separated(
          controller: _controller,
          itemCount: restaurants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurants[index],
                    ));
              },
              child: RestaurantInfoCard(
                restaurantIcon: restaurants[index].photo,
                backgroundImage: restaurants[index].background,
                packetNumber: 0 == 0 ? 'tükendi' : '4 paket',
                restaurantName: restaurants[index].name,
                grade: "4.7",
                location: restaurants[index].city,
                distance: "500 m",
                availableTime: '1-4',
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        ),
      ),
    );
  }

  Row buildRowTitleLeftRightLocation(
      BuildContext context, String titleLeft, String titleRight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
          },
          child: LocaleText(
            text: titleRight,
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
              height: 2.0,
            ),
            alignment: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildRowTitleLeftRightNearMeAll(
      BuildContext context, String titleLeft, String titleRight) {
    return Row(
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
              height: 2.0,
            ),
            alignment: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.72),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25.0),
          left: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        decoration: InputDecoration(
            suffixIcon: SvgPicture.asset(
              ImageConstant.COMMONS_SEARCH_ICON,
            ),
            border: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            errorBorder: buildOutlineInputBorder(),
            disabledBorder: buildOutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.046)),
            hintText: "Yemek, restoran ara"),
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
}
