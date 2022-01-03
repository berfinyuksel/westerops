import 'package:flutter_bloc/flutter_bloc.dart';

class SumOldPriceOrderCubit extends Cubit<int> {
  SumOldPriceOrderCubit() : super(0);

  void sumprice(List<int> list) =>
      emit(list.fold(0, (previous, current) => previous + current));
}
