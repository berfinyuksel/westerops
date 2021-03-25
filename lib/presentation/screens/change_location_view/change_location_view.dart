import 'package:dongu_mobile/presentation/screens/change_location_view/components/change_location_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/cities_constant.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangeLocationView extends StatefulWidget {
  @override
  _ChangeLocationViewState createState() => _ChangeLocationViewState();
}

class _ChangeLocationViewState extends State<ChangeLocationView> {
  final TextEditingController searchController = new TextEditingController();

  var cities = CitiesConstant.cities;
  List<String> citiesIndexes = CitiesConstant.citiesIndexes();
  var searchedCities = [];
  var searchedCitiesIndexes = [];
  String searchedText = "";
  String chosedCity = "Adana";
  String chosedCityIndex = "01";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.change_location_title,
      body: Column(
        children: [
          Spacer(
            flex: 3,
          ),
          buildSearchBar(context),
          Spacer(
            flex: 3,
          ),
          ChangeLocationListTile(
            cityText: chosedCity,
            cityCodeText: chosedCityIndex,
          ),
          Spacer(
            flex: 2,
          ),
          Container(
            height: context.dynamicHeight(0.6),
            child: buildListView(),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget buildListView() {
    if (searchedText.isNotEmpty) {
      List tempList = [];
      List tempIndexList = [];

      for (int i = 0; i < cities.length; i++) {
        if (cities[i].toLowerCase().contains(searchedText.toLowerCase()) || citiesIndexes[i].contains(searchedText)) {
          tempList.add(cities[i]);
          tempIndexList.add("${i < 9 ? 0 : ""}${i + 1}");
        }
      }
      searchedCities = tempList;
      searchedCitiesIndexes = tempIndexList;
    }
    return ListView.builder(
      itemCount: searchedCities.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            setState(() {
              chosedCityIndex = searchedCitiesIndexes[index];
              chosedCity = searchedCities[index];
              searchController.clear();
            });
          },
          contentPadding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
          ),
          tileColor: Colors.white,
          title: Row(
            children: [
              Container(
                width: context.dynamicWidht(0.06),
                child: Text(
                  searchedCitiesIndexes[index],
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              Text(
                searchedCities[index],
                style: AppTextStyles.bodyTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          searchedText = "";
          searchedCities = cities;
          searchedCitiesIndexes = CitiesConstant.citiesIndexes();
        });
      } else {
        setState(() {
          searchedText = searchController.text;
        });
      }
    });
  }

  Padding buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: buildTextFormField(context),
    );
  }

  Container buildTextFormField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(25.0),
          right: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: searchController,
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        decoration: InputDecoration(
            prefixIcon: Container(
              margin: EdgeInsets.only(right: context.dynamicWidht(0.03)),
              child: SvgPicture.asset(
                ImageConstant.COMMONS_SEARCH_ICON,
              ),
            ),
            border: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            errorBorder: buildOutlineInputBorder(),
            disabledBorder: buildOutlineInputBorder(),
            contentPadding: EdgeInsets.zero,
            hintText: LocaleKeys.change_location_hint_text.locale),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(25.0),
        right: Radius.circular(4.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }
}
