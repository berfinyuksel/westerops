import 'package:dongu_mobile/data/repositories/filters_repository.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class SortFilterCubit extends Cubit<GenericState> {
  SortFilterCubit() : super(GenericInitial());

  Future<void> getDistanceFilter(bool isSelected) async {
    SharedPrefs.setSortByDistance(isSelected);
  }
}
 