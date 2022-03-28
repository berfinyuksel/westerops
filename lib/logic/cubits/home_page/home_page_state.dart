part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class HomePageLoading extends HomePageState {}
class HomePageCompleted extends HomePageState {}
class HomePageCancelState extends HomePageState {
  final bool isCancelVisible;

  HomePageCancelState(this.isCancelVisible);
}
