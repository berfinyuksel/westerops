import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteStatusCubit extends Cubit<int> {
  FavoriteStatusCubit() : super(401);

  void loginStatus(int status) {
    emit(status);
  }
}
