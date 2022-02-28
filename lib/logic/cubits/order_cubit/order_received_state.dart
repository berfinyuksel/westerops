part of'order_received_cubit.dart';


//TODO: order received state cubit icerisine entegre edilecek
abstract class OrderReceivedState {}

class OrderReceivedInital extends OrderReceivedState {}

class OrderReceivedLoading extends OrderReceivedState {}

class OrderReceivedAllOrders extends OrderReceivedState {
 final List<IyzcoOrderCreate>? response;
  OrderReceivedAllOrders({
    this.response,
  });
}
