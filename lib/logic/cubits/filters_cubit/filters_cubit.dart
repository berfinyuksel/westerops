import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit()
      : super(
          FiltersState(check: false, maxValue: 100, minValue: 0, checkList: [
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
        ]));

  void setCheckboxList(
    List<bool>? currentCheckList,
  ) {
    emit(FiltersState(
        checkList: state.checkList = currentCheckList,
        check: state.check = currentCheckList![0],
        maxValue: state.maxValue,
        minValue: state.minValue));
  }

  void setIsMinValue(int minValue) => emit(FiltersState(
      minValue: state.minValue = minValue.toDouble(),
      maxValue: state.maxValue,
      checkList: state.checkList));
  void setIsMaxValue(int maxValue) => emit(FiltersState(
      maxValue: state.maxValue = maxValue.toDouble(),
      minValue: state.minValue,
      checkList: state.checkList));
}
