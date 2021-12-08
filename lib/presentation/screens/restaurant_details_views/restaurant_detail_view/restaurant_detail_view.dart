import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/search_store.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import 'components/custom_card_and_body.dart';

class RestaurantDetailView extends StatefulWidget {
  final SearchStore? restaurant;
  const RestaurantDetailView({Key? key, this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailViewState createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: LocaleKeys.restaurant_detail_app_bar_title,
        body: ListView(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                    color: Colors.white,
                    height: context.dynamicHeight(0.16),
                    width: context.dynamicWidht(1),
                    child: Image.network(widget.restaurant!.background!,
                        fit: BoxFit.fill)),
                Column(
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.05),
                    ),
                    //spacer8-9
                    SizedBox(
                      height: context.dynamicHeight(0.093),
                    ),
                    CustomCardAndBody(restaurant: widget.restaurant!),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
