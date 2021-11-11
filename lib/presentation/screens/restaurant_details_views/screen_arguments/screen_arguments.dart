import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/model/search_store.dart';

class ScreenArgumentsRestaurantDetail {
  final SearchStore? restaurant;
  final OrderReceived? orderInfo;

  ScreenArgumentsRestaurantDetail({this.restaurant, this.orderInfo});
}
