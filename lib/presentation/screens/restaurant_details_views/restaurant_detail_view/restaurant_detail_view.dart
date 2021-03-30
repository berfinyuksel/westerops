import 'package:dongu_mobile/presentation/screens/restaurant_details_views/components/custom_card.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';

class RestaurantDetailView extends StatefulWidget {
  const RestaurantDetailView({Key? key}) : super(key: key);

  @override
  _RestaurantDetailViewState createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(child: CustomCard())
    );
  }
}
