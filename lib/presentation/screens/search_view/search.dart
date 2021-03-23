import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController? controller = TextEditingController();
  bool _valuePackage = false;

  final duplicateItems = ["fatih", "boran", "flutter", "mobil"];
  var items = <String>[];

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummyListData.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Arama Yap",
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    width: _valuePackage ? context.dynamicWidht(0.9) : context.dynamicWidht(0.7),
                    height: context.dynamicWidht(0.12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(4.0),
                      ),
                      color: Colors.white,
                      border: Border.all(
                        width: 2.0,
                        color: AppColors.borderAndDividerColor,
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                       onTap: () {
                        setState(() {
                          _valuePackage = !_valuePackage;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Yemek, restoran ara",
                        hintStyle:
                        AppTextStyles.bodyTextStyle.copyWith(fontSize: 16),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      controller: controller,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: context.dynamicWidht(0.13),
                    height: context.dynamicHeight(0.13),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellowColor,
                    ),
                    child: SvgPicture.asset(
                      // search
                      ImageConstant.SEARCH_ICON,
                      width: 17.36,
                      height: 25.56,
                    ),
                  ),
                ],
              ),

            ],
            
          ),
          _valuePackage ? Text("Vazgeç") : Text("data"),

          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text("List ${items[index]}"),
            );
          })
        ],
      ),
    );
  }
}
