import 'package:dongu_mobile/data/repositories/basket_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

setUpLocator() async {
  getIt.registerLazySingleton(() => BasketRepository());
}