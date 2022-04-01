abstract class ScaffoldState {}

class ScaffoldInitial extends ScaffoldState {}

class ScaffoldLoading extends ScaffoldState {}

class ScaffoldCompleted<T> extends ScaffoldState {
  final List<T> response;

  ScaffoldCompleted(this.response);
}

class ScaffoldError extends ScaffoldState {
  final String message;
  final String statusCode;

  ScaffoldError(this.message, this.statusCode);
}
