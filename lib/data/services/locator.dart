import 'package:dongu_mobile/data/repositories/avg_review_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/repositories/update_permission_for_com_repository.dart';
import '../repositories/basket_repository.dart';
import '../repositories/update_order_repository.dart';
import '../repositories/change_active_address_repository.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

setUpLocator() async {
  getIt.registerLazySingleton(() => BasketRepository());
  getIt.registerLazySingleton(() => UpdatePermissonRepository());
  getIt.registerLazySingleton(() => ChangeActiveAddressRepository());
  getIt.registerLazySingleton(() => UpdateOrderRepository());
  getIt.registerLazySingleton(() => IyzicoCardRepository());
  getIt.registerLazySingleton(() => AvgReviewRepository());
}
