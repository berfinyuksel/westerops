import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'custom_package_delivery_container.dart';

class PackageDeliveryFilterList extends StatefulWidget {
  PackageDeliveryFilterList({Key? key}) : super(key: key);

  @override
  _PackageDeliveryFilterListState createState() =>
      _PackageDeliveryFilterListState();
}

class _PackageDeliveryFilterListState extends State<PackageDeliveryFilterList> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
        expansionTileBody: CustomContainerPackageDelivery(),
        expansionTileTitle: LocaleKeys.filters_package_delivery_title);
  }
}