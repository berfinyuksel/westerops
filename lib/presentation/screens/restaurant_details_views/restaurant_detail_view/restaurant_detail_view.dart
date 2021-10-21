import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:flutter/material.dart';

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
        title: "Restoran Detayları",
        body: ListView(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                    color: Colors.black,
                    height: context.dynamicHeight(0.16),
                    width: context.dynamicWidht(1),
                    child: Image.network(widget.restaurant!.background!,
                        fit: BoxFit.fill)),
                Column(
                  children: [
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
