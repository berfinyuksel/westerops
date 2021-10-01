part of 'basket_counter_cubit.dart';

class BasketCounterState {
  List<String> menuList = [];
  int? menuId = 0;
  int? counter;
  BasketCounterState({
    this.counter,
    required this.menuList,
    this.menuId,
  });
}
