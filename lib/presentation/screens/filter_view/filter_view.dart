import 'package:flutter/material.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../widgets/scaffold/custom_scaffold.dart';

import 'components/choose_category_filter_list_tile.dart';
import 'components/clean_and_save_buttons.dart';
import 'components/package_delivery_filter_list_tile.dart';
import 'components/package_price_filter_list_tile.dart';
import 'components/payment_method_list_tile.dart';
import 'components/sort_filter_list_tile.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isDrawer: true,
        title: "Filtrele",
        isNavBar: true,
        body: Padding(
          padding: EdgeInsets.only(top: context.dynamicHeight(0.025)),
          child: Column(
            children: [
              Container(
                height: context.dynamicHeight(0.75),
                child: ListView(
                  children: [
                    SortFilterList(),
                    Divider(
                      height: context.dynamicHeight(0.001),
                    ),
                    PackagePriceFilterList(),
                    Divider(
                      height: context.dynamicHeight(0.001),
                    ),
                    PackageDeliveryFilterList(),
                    Divider(
                      height: context.dynamicHeight(0.001),
                    ),
                 // TODO Odeme sekli kaldirildi.
                    ChooseCategoryFilterList(),
                    // SizedBox(
                    //   height: context.dynamicHeight(0.34),
                    // ),
                  ],
                ),
              ),
              CleanAndSaveButtons()
              // Positioned(
              //   child: CleanAndSaveButtons(),
              //   bottom: 0,
              //   top: context.dynamicHeight(0.7),
              //   left: 0,
              //   right: 0,
              // )
            ],
          ),
        ));
  }
}
