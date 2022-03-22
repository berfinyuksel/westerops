
part of'category_name_cubit.dart';

abstract class CategoryNameState {}

class CategoryNameInital extends CategoryNameState {}

class CategoryNameLoading extends CategoryNameState {}

class CategoryNameCompleted extends CategoryNameState {
 final List<Result>? response;
  CategoryNameCompleted({
    this.response,
  });
}

class FilterCategoriesLoading extends CategoryNameState {}

class FilterCategoriesCompleted extends CategoryNameState {
 final List<SearchStore>? response;
  FilterCategoriesCompleted({
    this.response,
  });
}



