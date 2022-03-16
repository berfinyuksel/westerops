import 'package:flutter_bloc/flutter_bloc.dart';

class FilterFavorites extends Cubit<bool> {
  FilterFavorites() : super(false);

  void filterFavorites(bool isShow) {
    emit(isShow);
  }
}
