// import 'package:dongu_mobile/data/dummy_search_data/dummy_search_data.dart';
// import 'package:dongu_mobile/data/model/dummy_model.dart';
// import 'package:dongu_mobile/utils/constants/image_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../utils/extensions/context_extension.dart';
// import '../../../utils/extensions/string_extension.dart';
// import '../../../utils/locale_keys.g.dart';
// import '../../../utils/theme/app_colors/app_colors.dart';
// import '../../../utils/theme/app_text_styles/app_text_styles.dart';
// import '../../widgets/text/locale_text.dart';
// import 'components/horizontal_list_category_bar.dart';
// import 'components/horizontal_list_trend_bar.dart';
// import 'components/search_bar.dart';

// class SearchView extends StatefulWidget {
//   const SearchView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _SearchViewState createState() => _SearchViewState();
// }

// class _SearchViewState extends State<SearchView> {
//   TextEditingController? controller = TextEditingController();
//   //bool _valueSearch = false;
//   final duplicateItems = [
//     LocaleKeys.search_item1.locale,
//     LocaleKeys.search_item2.locale,
//     LocaleKeys.search_item3.locale
//   ];
//   var items = <String>[];

//   late List<Search> searches;
//   String query = '';

//   bool scroolCategories = true;
//   bool scroolTrend = true;
//   bool visible = true;
//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     super.initState();
//     searches = allSearches;
//   }

//   void filterSearchResults(String query) {
//     List<String> dummySearchList = <String>[];
//     dummySearchList.addAll(duplicateItems);
//     if (query.isNotEmpty) {
//       List<String> dummyListData = <String>[];
//       dummyListData.forEach((item) {
//         if (item.contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//         items.addAll(duplicateItems);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return buildBody(context);
//   }

//   GestureDetector buildBody(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Column(
//         children: [
//           Row(
//       children: [
//         Container(
//           width: visible ? context.dynamicWidht(0.85) : context.dynamicWidht(0.70),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25.0),
//               bottomLeft: Radius.circular(25.0),
//             ),
//             color: Colors.white,
//           ),
//           child: TextFormField(
//             controller: controller,
            
//             onTap: (){},
//             onChanged: searchSearch,
//             cursorColor: AppColors.cursorColor,
//             style: AppTextStyles.bodyTextStyle,
//             decoration: InputDecoration(
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.only(right: context.dynamicWidht(0.04)),
//                   child: SvgPicture.asset(
//                     ImageConstant.COMMONS_SEARCH_ICON,
//                   ),
//                 ),
//                 border: buildOutlineInputBorder(),
//                 focusedBorder: buildOutlineInputBorder(),
//                 enabledBorder: buildOutlineInputBorder(),
//                 errorBorder: buildOutlineInputBorder(),
//                 disabledBorder: buildOutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.only(left: context.dynamicWidht(0.046)),
//                 hintText: "Yemek, restoran ara"),
//           ),
//         ),
//         Spacer(),
//       ],
//     ),
//             Visibility(
//               // visible: visible,
//               child: Expanded(
//               child: ListView.builder(
//                 itemCount: searches.length,
//                 itemBuilder: (context, index) {
//                   final search = searches[index];
            
//                   return buildSearch(search);
//                 },
//               ),
//                       ),
//             ),
//           // Visibility(
//           //     visible: visible, child: searchHistoryAndCleanTexts(context)),
//           // Visibility(visible: visible, child: dividerOne(context)),
//           // Visibility(visible: visible, child: Spacer(flex: 2)),
//           // searchListViewBuilder(),
//           // Spacer(flex: 4),
//           // Visibility(visible: visible, child: popularSearchText(context)),
//           // Visibility(visible: visible, child: dividerSecond(context)),
//           // Spacer(flex: 4),
//           // Visibility(visible: visible, child: horizontalListTrend(context)),
//           // Spacer(flex: 4),
//           // Visibility(visible: visible, child: categoriesText(context)),
//           // Visibility(visible: visible, child: dividerThird(context)),
//           // Spacer(flex: 1),
//           // Visibility(visible: visible, child: horizontalListCategory(context)),
//           // Spacer(flex: 14),
//         ],
//       ),
//     );
//   }
//   OutlineInputBorder buildOutlineInputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(25.0),
//         bottomLeft: Radius.circular(25.0),
//       ),
//       borderSide: BorderSide(
//         width: 2.0,
//         color: AppColors.borderAndDividerColor,
//       ),
//     );
//   }
//   Padding horizontalListCategory(BuildContext context) {
//     return Padding(
//       padding: scroolCategories
//           ? EdgeInsets.only(
//               left: 26,
//               right: 0,
//             )
//           : EdgeInsets.only(
//               left: 0,
//               right: 26,
//             ),
//       child: Container(
//           height: context.dynamicHeight(0.19),
//           child: NotificationListener<ScrollUpdateNotification>(
//               onNotification: (ScrollUpdateNotification notification) {
//                 setState(() {
//                   if (notification.metrics.pixels > 1) {
//                     scroolCategories = false;
//                   } else if (notification.metrics.pixels < 1) {
//                     scroolCategories = true;
//                   }
//                 });

//                 return true;
//               },
//               child: CustomHorizontalListCategory())),
//     );
//   }

//   Padding dividerThird(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: context.dynamicWidht(0.06),
//       ),
//       child: Divider(
//         color: AppColors.borderAndDividerColor,
//         thickness: 5,
//       ),
//     );
//   }

//   Padding categoriesText(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: context.dynamicWidht(0.6),
//       ),
//       child: LocaleText(
//         text: LocaleKeys.search_text4,
//         style: AppTextStyles.bodyTitleStyle,
//       ),
//     );
//   }

//   Padding horizontalListTrend(BuildContext context) {
//     return Padding(
//       padding: scroolTrend
//           ? EdgeInsets.only(
//               left: 26,
//               right: 0,
//             )
//           : EdgeInsets.only(
//               left: 0,
//               right: 26,
//             ),
//       child: Container(
//           height: context.dynamicHeight(0.04),
//           child: NotificationListener<ScrollUpdateNotification>(
//               onNotification: (ScrollUpdateNotification notification) {
//                 setState(() {
//                   if (notification.metrics.pixels > 1) {
//                     scroolTrend = false;
//                   } else if (notification.metrics.pixels < 1) {
//                     scroolTrend = true;
//                   }
//                 });

//                 return true;
//               },
//               child: CustomHorizontalListTrend())),
//     );
//   }

//   Padding dividerSecond(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: context.dynamicWidht(0.06),
//       ),
//       child: Divider(
//         color: AppColors.borderAndDividerColor,
//         thickness: 5,
//       ),
//     );
//   }

//   Padding popularSearchText(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         right: context.dynamicWidht(0.5),
//       ),
//       child: LocaleText(
//         text: LocaleKeys.search_text3,
//         style: AppTextStyles.bodyTitleStyle,
//       ),
//     );
//   }

//   ListView searchListViewBuilder() {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: context.dynamicWidht(0.06),
//             ),
//             decoration: BoxDecoration(color: Colors.white),
//             child: ListTile(
//               leading: LocaleText(
//                 text: "${items[index]}",
//                 style: AppTextStyles.bodyTextStyle,
//               ),
//               trailing: visible ? null : Icon(Icons.chevron_right),
//             ),
//           );
//         });
//   }

//   Padding dividerOne(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: context.dynamicWidht(0.06),
//       ),
//       child: Divider(
//         color: AppColors.borderAndDividerColor,
//         thickness: 5,
//       ),
//     );
//   }

//   Padding searchHistoryAndCleanTexts(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: context.dynamicWidht(0.06),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           LocaleText(
//             text: LocaleKeys.search_text1,
//             style: AppTextStyles.bodyTitleStyle,
//           ),
//           Spacer(),
//           LocaleText(
//             text: LocaleKeys.search_text2,
//             style: AppTextStyles.bodyTitleStyle
//                 .copyWith(color: AppColors.orangeColor, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Padding searchBar(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: context.dynamicWidht(0.06),
//           vertical: context.dynamicHeight(0.03),
//         ),
//         child: CustomSearchBar(
//           containerPadding:
//               visible ? context.dynamicWidht(0.85) : context.dynamicWidht(0.70),
//           onTap: () {
//             setState(() {
//               visible = !visible;
//             });
//           },
//           onChanged: (value) {
//             filterSearchResults(value);
//             searchSearch(query);
//           },
//           controller: controller,
//           hintText: LocaleKeys.search_text5.locale,
//           textButton: visible
//               ? null
//               : TextButton(
//                   onPressed: () {
//                     FocusScope.of(context).unfocus();
//                     setState(() {
//                       FocusScope.of(context).unfocus();

//                       visible = !visible;
//                     });
//                   },
//                   child: Text(
//                     LocaleKeys.search_cancel_button.locale,
//                     style: AppTextStyles.bodyTitleStyle
//                         .copyWith(color: AppColors.orangeColor, fontSize: 12),
//                   )),
//         ));
//   }

//   Widget buildSearch(Search searches) => ListTile(
//         leading: Image.network(
//           searches.urlImage,
//           fit: BoxFit.cover,
//           width: 50,
//           height: 50,
//         ),
//         title: Text(searches.meal),
//         subtitle: Text(searches.restaurant),
//       );
  
//   void searchSearch(String query) {
//     final search = allSearches.where((searches) {
//       final mealLower = searches.meal.toLowerCase();
//       final restaurantLower = searches.restaurant.toLowerCase();
//       final searchLower = query.toLowerCase();

//       return mealLower.contains(searchLower) ||
//           restaurantLower.contains(searchLower);
//     }).toList();

//     setState(() {
//       this.query = query;
//       this.searches = search;
//     });
//   }
// }
