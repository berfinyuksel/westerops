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
        title: "Filtrele",
        body: ListView(
          children: [
            SortFilterList(),
            PackagePriceFilterList(),
            PackageDeliveryFilterList(),
            PaymentMethodFilterList(),
            ChooseCategoryFilterList(),
            SizedBox(
              height: context.dynamicHeight(0.34),
            ),
            CleanAndSaveButtons()
          ],
        ));
  }
}
