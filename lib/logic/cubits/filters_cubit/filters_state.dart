part of 'filters_cubit.dart';

class FiltersState {
  double? minValue;
  double? maxValue;
  bool? check;
  List<bool>? checkList;
  FiltersState({
    this.checkList,
    this.check,
    this.maxValue,
    this.minValue,
  });
}
