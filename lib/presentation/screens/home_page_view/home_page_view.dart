import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/store_cubit/store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/my_favorites_view/components/address_text.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/screens/search_view/components/horizontal_list_category_bar.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_card/restaurant_info_card.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<StoreCubit>().getStores();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<StoreCubit>().state;
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        return Center(child: buildBody(context, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  ListView buildBody(BuildContext context, GenericCompleted state) {
    return ListView(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        top: context.dynamicHeight(0.02),
        bottom: context.dynamicHeight(0.02),
      ),
      children: [
        buildRowTitleLeftRight(context, LocaleKeys.home_page_location, LocaleKeys.home_page_edit),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        AddressText(),
        SizedBox(height: context.dynamicHeight(0.03)),
        Row(
          children: [
            buildSearchBar(context),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
              },
              child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
          ],
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
        buildRowTitleLeftRight(context, LocaleKeys.home_page_closer, LocaleKeys.home_page_see_all),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.02)),
        buildListView(context, state),
        SizedBox(height: context.dynamicHeight(0.04)),
        LocaleText(
          text: LocaleKeys.home_page_categories,
          style: AppTextStyles.bodyTitleStyle,
        ),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        Container(height: context.dynamicHeight(0.16), child: CustomHorizontalListCategory()),
        LocaleText(
          text: LocaleKeys.home_page_opportunities,
          style: AppTextStyles.bodyTitleStyle,
        ),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        buildListView(context, state),
      ],
    );
  }

  Container buildListView(BuildContext context, GenericCompleted state) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: ListView.separated(
        itemCount: state.response[0].results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String startTime = state.response[0].results[index].calendar[0].startDate.split("T")[1];
          String endTime = state.response[0].results[index].calendar[0].endDate.split("T")[1];

          startTime = "${startTime.split(":")[0]}:${startTime.split(":")[1]}";
          endTime = "${endTime.split(":")[0]}:${endTime.split(":")[1]}";

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(state.response[0].results[index]));
            },
            child: RestaurantInfoCard(
              restaurantIcon: state.response[0].results[index].photo,
              backgroundImage: state.response[0].results[index].background,
              packetNumber: state.response[0].results[index].boxes.length == 0 ? 'tükendi' : '${state.response[0].results[index].boxes.length} paket',
              restaurantName: state.response[0].results[index].name,
              grade: "4.7",
              location: state.response[0].results[index].city,
              distance: "254m",
              availableTime: '$startTime-$endTime',
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: context.dynamicWidht(0.04),
        ),
      ),
    );
  }

  Row buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
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
