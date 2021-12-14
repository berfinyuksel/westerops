import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPaddingCubit extends Cubit<double> {
  CategoryPaddingCubit() : super(0);

  void setPadding(double sumOfRadius) => emit(sumOfRadius);
}
