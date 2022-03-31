import '../../../data/model/box.dart';

abstract class CustomScaffoldState {}

class CustomScaffoldInitial extends CustomScaffoldState {}

class CustomScaffoldLoading extends CustomScaffoldState {}

class CustomScaffoldCompleted extends CustomScaffoldState {
  final List<Box> packages;
  
  CustomScaffoldCompleted(this.packages);
}
