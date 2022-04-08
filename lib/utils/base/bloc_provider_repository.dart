import 'package:dongu_mobile/data/repositories/address_repository.dart';
import 'package:dongu_mobile/data/repositories/box_repository.dart';
import 'package:dongu_mobile/data/repositories/bulk_update_notifications_repository.dart';
import 'package:dongu_mobile/data/repositories/favourite_repository.dart';
import 'package:dongu_mobile/data/repositories/filters_repository.dart';
import 'package:dongu_mobile/data/repositories/get_notification_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_creat_order_with_3d.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_send_request_repository.dart';
import 'package:dongu_mobile/data/repositories/notification_repository.dart';
import 'package:dongu_mobile/data/repositories/order_repository.dart';
import 'package:dongu_mobile/data/repositories/put_notification_repository.dart';
import 'package:dongu_mobile/data/repositories/search_location_repository.dart';
import 'package:dongu_mobile/data/repositories/store_boxes_repository.dart';
import 'package:dongu_mobile/data/repositories/store_courier_hours_repository.dart';
import 'package:dongu_mobile/data/repositories/time_interval_repository.dart';
import 'package:dongu_mobile/data/repositories/user_address_repository.dart';
import 'package:dongu_mobile/data/repositories/user_authentication_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/logic/cubits/address_cubit/address_cubit.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/cancel_order_cubit/cancel_cancel_cubit.dart';
import 'package:dongu_mobile/logic/cubits/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/clean_button_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/favorites_filter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/sort_filters_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_order_create_with_3d_cubit/iyzico_order_create_with_3d_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/bulk_update_notication_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/put_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/category_padding_values_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/near_me_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/opportunity_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/error_message.cubit.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_location_cubit/search_location_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/social_login_cubit/social_login_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/swipe_route_cubit.dart/swipe_route_cubit.dart';
import 'package:dongu_mobile/logic/cubits/time_interval_cubit/time_interval_cubit.dart';
import 'package:dongu_mobile/logic/cubits/user_address_cubit/user_address_cubit.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_email_control_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/login_status_cubit/login_status_cubit.dart';

class BlocProviderRepository {
  List<BlocProvider> multiBlocProvider = [
    BlocProvider<BasketCounterCubit>(create: (_) => BasketCounterCubit()),
    BlocProvider<CancelOrderCubit>(create: (_) => CancelOrderCubit()),
    BlocProvider<CancelCancelCubit>(create: (_) => CancelCancelCubit()),
    BlocProvider<FilterFavorites>(create: (_) => FilterFavorites()),
    BlocProvider<CleanButton>(create: (_) => CleanButton()),
    BlocProvider<SwipeRouteButton>(create: (_) => SwipeRouteButton()),
    BlocProvider<NotificationsCounterCubit>(create: (_) => NotificationsCounterCubit()),
    BlocProvider<NearMePaddingCubit>(create: (_) => NearMePaddingCubit()),
    BlocProvider<IyzicoCardCubit>(create: (_) => IyzicoCardCubit(IyzicoCardRepository())),
    BlocProvider<IyzicoOrderCreateWith3DCubit>(
        create: (_) => IyzicoOrderCreateWith3DCubit(IyzicoCreateOrderWith3DRepository())),
    BlocProvider<OpportunityPaddingCubit>(create: (_) => OpportunityPaddingCubit()),
    BlocProvider<CategoryPaddingCubit>(create: (_) => CategoryPaddingCubit()),
    BlocProvider<OrderBarCubit>(create: (_) => OrderBarCubit()),
    BlocProvider<SocialLoginCubit>(create: (_) => SocialLoginCubit()),
    BlocProvider<SumPriceOrderCubit>(create: (_) => SumPriceOrderCubit()),
    BlocProvider<SumOldPriceOrderCubit>(create: (_) => SumOldPriceOrderCubit()),
    BlocProvider<SortFilterCubit>(create: (_) => SortFilterCubit()),
    BlocProvider<SearchLocationCubit>(create: (context) => SearchLocationCubit(SampleSearchLocationRepository())),
    BlocProvider<SendRequestCubit>(create: (context) => SendRequestCubit(SampleSendRequestRepository())),
    BlocProvider<NotificationCubit>(create: (context) => NotificationCubit(SampleNotificationRepository())),
    BlocProvider<GetNotificationCubit>(create: (context) => GetNotificationCubit(SampleGetNotificationRepository())),
    BlocProvider<PutNotificationCubit>(create: (context) => PutNotificationCubit(SamplePutNotificationRepository())),
    BlocProvider<BulkUpdateNotificationCubit>(
        create: (context) => BulkUpdateNotificationCubit(SampleBulkUpdateNotificationRepository())),
    BlocProvider<TimeIntervalCubit>(create: (context) => TimeIntervalCubit(SampleTimeIntervalRepository())),
    BlocProvider<OrderReceivedCubit>(create: (context) => sl<OrderReceivedCubit>()),
    BlocProvider<StoreCourierCubit>(create: (context) => StoreCourierCubit(SampleStoreCourierHoursRepository())),
    BlocProvider<SearchStoreCubit>(create: (context) => sl<SearchStoreCubit>()),
    BlocProvider<StoreBoxesCubit>(create: (context) => StoreBoxesCubit(SampleStoreBoxesRepository())),
    BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
    BlocProvider<BoxCubit>(create: (context) => BoxCubit(SampleBoxRepository())),
    BlocProvider<UserAuthCubit>(create: (context) => UserAuthCubit(SampleUserAuthenticationRepository())),
    BlocProvider<OrderCubit>(create: (context) => OrderCubit(SampleOrderRepository())),
    BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit(SampleFavoriteRepository())),
    BlocProvider<CategoryNameCubit>(create: (context) => sl<CategoryNameCubit>()),
    BlocProvider<AddressCubit>(create: (context) => AddressCubit(SampleAdressRepository())),
    BlocProvider<UserAddressCubit>(create: (context) => UserAddressCubit(SampleUserAdressRepository())),
    BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
    BlocProvider<FiltersCubit>(create: (context) => FiltersCubit()),
    BlocProvider<FiltersManagerCubit>(create: (context) => FiltersManagerCubit(SampleFiltersRepository())),
    BlocProvider<LoginStatusCubit>(create: (context) => sl<LoginStatusCubit>()),
    BlocProvider<ErrorMessageCubit>(create: (context) => ErrorMessageCubit()),
    BlocProvider<UserEmailControlCubit>(create: (context) => UserEmailControlCubit()),


  ];
}
