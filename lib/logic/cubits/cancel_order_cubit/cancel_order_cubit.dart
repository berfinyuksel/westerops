import 'package:flutter_bloc/flutter_bloc.dart';

class CancelOrderCubit extends Cubit<bool> {
  CancelOrderCubit() : super(true);

  void cancelOrder(bool cancelOrder) {
    emit(cancelOrder);
  }
}
