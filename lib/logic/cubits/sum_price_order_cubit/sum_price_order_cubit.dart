import 'package:flutter_bloc/flutter_bloc.dart';

class SumPriceOrderCubit extends Cubit<int> {
  SumPriceOrderCubit() : super(0);

  List<int> priceList = [];

  void incrementPrice(int price) {
    priceList.add(price);
    emit(priceList.fold(0, (previous, current) => previous + current));
  }

  void decrementPrice(int price) {
    priceList.remove(price);
    emit(priceList.fold(0, (previous, current) => previous + current));
  }

  void clearPrice() {
    emit(0);
  }
}
