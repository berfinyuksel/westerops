import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';

import '../../../../data/model/order_received.dart';
import '../../../../data/model/search_store.dart';

class ScreenArgumentsRestaurantDetail {
  final SearchStore? restaurant;
  final OrderReceived? orderInfoReceived;
  final IyzcoOrderCreate? orderInfo;
  ScreenArgumentsRestaurantDetail(
      {this.restaurant, this.orderInfo, this.orderInfoReceived});
}
