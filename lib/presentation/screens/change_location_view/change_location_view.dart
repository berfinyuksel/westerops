import 'package:flutter/services.dart';

import '../../../data/shared/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/cities_constant.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/change_location_list_tile.dart';

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
  String chosedCity = SharedPrefs.getUserAddress;
  String chosedCityIndex = "34";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.change_location_title,
      body: Column(
        children: [
          /* Spacer(
            flex: 3,
          ),*/

          //buildSearchBar(context),
          /* Spacer(
            flex: 3,
          ),*/
          SizedBox(height: context.dynamicHeight(0.01)),
          ChangeLocationListTile(
            cityText: chosedCity,
            cityCodeText: chosedCityIndex,
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            height: context.dynamicHeight(0.6),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.05)),
                child: Text(
                  "Şimdilik sadece İstanbul bölgesinde hizmet veriyoruz. Yakında diğer bölgelerde hizmet vermeye başlayacağız... 🙂",
                  style: AppTextStyles.subTitleBoldStyle
                      .copyWith(fontSize: 15, color: AppColors.textColor),
                )),
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
        if (cities[i].toLowerCase().contains(searchedText.toLowerCase()) ||
            citiesIndexes[i].contains(searchedText)) {
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
              SharedPrefs.setUserAddress(chosedCity);
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

    for (int i = 0; i < cities.length; i++) {
      if (cities[i] == chosedCity) {
        chosedCityIndex = citiesIndexes[i];
      }
    }

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
        //enableInteractiveSelection: false,
        //enabled: false,
        inputFormatters: [
         // FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
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
