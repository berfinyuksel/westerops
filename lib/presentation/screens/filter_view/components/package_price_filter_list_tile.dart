import 'package:flutter/material.dart';

import '../../../../utils/locale_keys.g.dart';
import 'custom_expansion_tile.dart';
import 'custom_sliderbar_textfield.dart';

class PackagePriceFilterList extends StatefulWidget {
  PackagePriceFilterList({Key? key}) : super(key: key);

  @override
  _PackagePriceFilterListState createState() => _PackagePriceFilterListState();
}

class _PackagePriceFilterListState extends State<PackagePriceFilterList> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
        expansionTileBody: CustomSliderBarAndTextField(),
        expansionTileTitle: LocaleKeys.filters_package_price_title);
  }
}
