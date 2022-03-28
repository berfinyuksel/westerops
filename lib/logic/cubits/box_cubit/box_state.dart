import '../../../data/model/box.dart';

abstract class BoxState {}

class BoxInitial extends BoxState {}

class BoxLoading extends BoxState {}

class BoxCompleted extends BoxState {
  final List<Box> packages;

  BoxCompleted(this.packages);
}
