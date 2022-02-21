import 'package:flutter_bloc/flutter_bloc.dart';

class FilterFavorites extends Cubit<bool> {
  FilterFavorites() : super(true);

  void filterFavorites(bool isShow) {
    emit(isShow);
  }
}
