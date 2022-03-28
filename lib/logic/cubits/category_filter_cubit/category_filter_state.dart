part of 'category_filter_cubit.dart';

@immutable
abstract class CategoryFilterState {}

class FilterCategoriesInitial extends CategoryFilterState {}

class FilterCategoriesLoading extends CategoryFilterState {}

class FilterCategoriesCompleted extends CategoryFilterState {
 final List<SearchStore>? response;
  FilterCategoriesCompleted({
    this.response,
  });
}

class FilterCategoriesError extends CategoryFilterState {
  final String errorMessage;

  FilterCategoriesError(this.errorMessage);
}