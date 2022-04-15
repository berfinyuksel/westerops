import 'package:dongu_mobile/data/repositories/address_repository.dart';
import 'package:dongu_mobile/data/repositories/avg_review_repository.dart';
import 'package:dongu_mobile/data/repositories/category_name_repository.dart';
import 'package:dongu_mobile/data/repositories/filters_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/repositories/order_received_repository.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/repositories/update_permission_for_com_repository.dart';
import 'package:dongu_mobile/data/repositories/user_authentication_repository.dart';
import 'package:dongu_mobile/logic/cubits/address_cubit/address_cubit.dart';
import 'package:dongu_mobile/logic/cubits/category_filter_cubit/category_filter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'package:dongu_mobile/logic/cubits/home_page/home_page_cubit.dart';
import 'package:dongu_mobile/logic/cubits/login_status_cubit/login_status_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/error_message.cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_email_control_cubit.dart';
import 'package:dongu_mobile/utils/base/bloc_provider_repository.dart';
import 'package:dongu_mobile/utils/base/svg_image_repository.dart';
import '../../logic/cubits/box_cubit/box_cubit.dart';
import '../../logic/cubits/favourite_cubit/favourite_cubit.dart';
import '../../logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';
import '../../logic/cubits/order_cubit/order_cubit.dart';
import '../../logic/cubits/search_cubit/search_cubit.dart';
import '../repositories/basket_repository.dart';
import '../repositories/box_repository.dart';
import '../repositories/favourite_repository.dart';
import '../repositories/order_repository.dart';
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
  getIt.registerLazySingleton(() => SampleFavoriteRepository());
  getIt.registerLazySingleton(() => SampleFiltersRepository());
  getIt.registerLazySingleton(() => SampleAdressRepository());
  getIt.registerLazySingleton(() => SampleCategoryNameRepository());
  getIt.registerFactory(() => SampleBoxRepository());
  getIt.registerLazySingleton(() => SampleOrderRepository());
  getIt.registerLazySingleton(() => SampleUserAuthenticationRepository());
  // getIt.registerLazySingleton(() => IyzicoCardRepository());

  //Cubits

  getIt.registerLazySingleton(() => OrderReceivedCubit(sl()));
  getIt.registerLazySingleton(() => HomePageCubit());
  getIt.registerLazySingleton(() => SearchStoreCubit(sl()));
  getIt.registerLazySingleton(() => SearchCubit(sl()));
  getIt.registerLazySingleton(() => LoginStatusCubit());
  getIt.registerFactory(() => FavoriteCubit(sl()));
  getIt.registerLazySingleton(() => AddressCubit(sl()));
  getIt.registerFactory(() => CategoryNameCubit(sl()));
  getIt.registerFactory(() => CategoryFilterCubit(sl()));
  getIt.registerFactory(() => BoxCubit(sl()));
  getIt.registerFactory(() => OrderCubit(sl()));
  getIt.registerLazySingleton(() => ErrorMessageCubit());
  getIt.registerLazySingleton(() => UserEmailControlCubit());
  getIt.registerFactory(() => IyzicoCardCubit(sl()));
}
