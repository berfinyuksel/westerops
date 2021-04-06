import 'package:dongu_mobile/presentation/screens/filter_view/components/package_price_filter_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'components/choose_category_filter_list_tile.dart';
import 'components/clean_and_save_buttons.dart';
import 'components/payment_method_list_tile.dart';
import 'components/package_delivery_filter_list_tile.dart';
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
              height: context.dynamicHeight(0.12),
            ),
            CleanAndSaveButtons()
          ],
        ));
  }
}
