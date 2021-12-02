import '../../../../data/model/order_received.dart';
import '../../../../data/model/search_store.dart';

class ScreenArgumentsRestaurantDetail {
  final SearchStore? restaurant;
  final OrderReceived? orderInfo;

  ScreenArgumentsRestaurantDetail({this.restaurant, this.orderInfo});
}
