abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteCompleted<T> extends FavoriteState {
  final List<T> response;

  FavoriteCompleted(this.response);
}

class IsFavoriteChange extends FavoriteState{
  final bool isFavorite;

  IsFavoriteChange(this.isFavorite);
}

class FavoriteError extends FavoriteState {
  final String message;
  final String statusCode;

  FavoriteError(this.message, this.statusCode);
}
