import 'package:flutter_bloc/flutter_bloc.dart';

class SumOldPriceOrderCubit extends Cubit<int> {
  SumOldPriceOrderCubit() : super(0);

  List<int> priceList = [];

  void incrementOldPrice(int price) {
    priceList.add(price);
    emit(priceList.fold(0, (previous, current) => previous + current));
  }

  void decrementOldPrice(int price) {
    priceList.remove(price);
    emit(priceList.fold(0, (previous, current) => previous + current));
  }

  void clearOldPrice() {

    emit(0);
  }
}
