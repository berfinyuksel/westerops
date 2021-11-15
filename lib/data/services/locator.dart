import 'package:dongu_mobile/data/repositories/basket_repository.dart';
import 'package:dongu_mobile/data/repositories/cancel_order_repository.dart';
import 'package:dongu_mobile/data/repositories/change_active_address_repository.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

setUpLocator() async {
  getIt.registerLazySingleton(() => BasketRepository());
  getIt.registerLazySingleton(() => ChangeActiveAddressRepository());
  getIt.registerLazySingleton(() => CancelOrderRepository());
}
