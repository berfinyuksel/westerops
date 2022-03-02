import 'package:dongu_mobile/data/repositories/avg_review_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/repositories/order_received_repository.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/repositories/update_permission_for_com_repository.dart';
import 'package:dongu_mobile/logic/cubits/home_page/home_page_cubit.dart';
import 'package:dongu_mobile/logic/cubits/login_status_cubit/login_status_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/utils/base/bloc_provider_repository.dart';
import 'package:dongu_mobile/utils/base/svg_image_repository.dart';
import '../../logic/cubits/search_cubit/search_cubit.dart';
import '../repositories/basket_repository.dart';
import '../repositories/search_repository.dart';
import '../repositories/update_order_repository.dart';
import '../repositories/change_active_address_repository.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

setUpLocator() async {
  //Repositories
  getIt.registerLazySingleton(() => SampleOrderReceivedRepository());
  getIt.registerLazySingleton(() => SampleSearchStoreRepository());
  getIt.registerLazySingleton(() => BasketRepository());
  getIt.registerLazySingleton(() => UpdatePermissonRepository());
  getIt.registerLazySingleton(() => ChangeActiveAddressRepository());
  getIt.registerLazySingleton(() => UpdateOrderRepository());
  getIt.registerLazySingleton(() => IyzicoCardRepository());
  getIt.registerLazySingleton(() => AvgReviewRepository());
  getIt.registerLazySingleton(() => BlocProviderRepository());
  getIt.registerLazySingleton(() => SvgImageRepository());
  getIt.registerLazySingleton(() => SampleSearchRepository());
  //Cubits

  getIt.registerLazySingleton(() => OrderReceivedCubit(sl()));
  getIt.registerLazySingleton(() => HomePageCubit());
  getIt.registerLazySingleton(() => SearchStoreCubit(sl()));
  getIt.registerLazySingleton(() => SearchCubit(sl()));
  getIt.registerLazySingleton(() => LoginStatusCubit());

}
