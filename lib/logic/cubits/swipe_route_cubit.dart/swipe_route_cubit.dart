import 'package:flutter_bloc/flutter_bloc.dart';

class SwipeRouteButton extends Cubit<bool> {
  SwipeRouteButton() : super(true);

  void swipeRouteButton(bool isShow) {
    emit(isShow);
  }
}
