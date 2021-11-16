import 'package:dongu_mobile/data/repositories/avg_review_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AvgReviewCubit extends Cubit<StatusCode> {
  final AvgReviewRepository _avgReviewRepository;
  AvgReviewCubit(this._avgReviewRepository) : super(StatusCode.success);

  Future<void> postReview(int mealPoint, int servicePoint, int qualityPoint,
      int orderId, int userId, int storeId) async {
    final response = await _avgReviewRepository.postReview(
        mealPoint, servicePoint, qualityPoint, orderId, userId, storeId);
    emit(response);
  }

  Future<void> getReview() async {
    final response = await _avgReviewRepository.getReview();
    emit(response);
  }
}
