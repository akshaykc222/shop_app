import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_app/shop/data/data_sources/remote/auth_data_source.dart';
import 'package:shop_app/shop/data/data_sources/remote/deliveryman_data_source.dart';
import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/models/category_id.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/order_listing_model.dart';
import 'package:shop_app/shop/data/models/product_model.dart';
import 'package:shop_app/shop/data/models/status_model.dart';
import 'package:shop_app/shop/data/models/store_timing_model.dart';
import 'package:shop_app/shop/data/models/tag_model.dart';
import 'package:shop_app/shop/data/models/unit_model.dart';
import 'package:shop_app/shop/data/repositories/auth_remote_data_rempository_impl.dart';
import 'package:shop_app/shop/data/repositories/deliveryman_repository.dart';
import 'package:shop_app/shop/data/repositories/product_repository_impl.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';
import 'package:shop_app/shop/domain/repositories/deliveryman_repository.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';
import 'package:shop_app/shop/domain/use_cases/add_category_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/add_deliveryman_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/add_product_request_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/category_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/change_account_detail_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/change_order_status_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/change_password_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/delete_category_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/delete_product_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/deliveryman_listing_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/edit_deliveryman_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/edit_order_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_account_details_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_customer_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_dash_board_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_delivery_man_detail_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_order_detail_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_order_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_product_details_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/get_sub_categories.dart';
import 'package:shop_app/shop/domain/use_cases/get_tag_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_timing_store_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/get_unit_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/login_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/product_status_update_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/product_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/update_category_status_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/update_store_offline_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/update_timing_use_case.dart';
import 'package:shop_app/shop/presentation/manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/delivery_bloc/delivery_man_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/login_bloc/login_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/customer_bloc/customer_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/hour_tile_cubit/cubit/store_timing_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';

import '../core/api_provider.dart';
import '../core/hive_service.dart';
import 'core/connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(sl()));
  //data source
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()));
  sl.registerLazySingleton<DeliveryManDataSource>(
      () => DeliverManDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl(), sl()));

  //repository'
  sl.registerLazySingleton<AuthRemoteDataRepository>(
      () => AuthRemoteDataRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton<DeliveryManRepository>(
      () => DeliveryManRepositoryImpl(sl()));

  //use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<GetTagUseCase>(() => GetTagUseCase(sl()));
  sl.registerLazySingleton<GetSubCategoriesUseCase>(
      () => GetSubCategoriesUseCase(sl()));
  sl.registerLazySingleton<GetUnitUseCase>(() => GetUnitUseCase(sl()));
  sl.registerLazySingleton<GetAccountDetailUseCase>(
      () => GetAccountDetailUseCase(sl()));
  sl.registerLazySingleton<CategoryUseCase>(() => CategoryUseCaseImpl(sl()));
  sl.registerLazySingleton<ProductListUseCase>(() => ProductListUseCase(sl()));
  sl.registerLazySingleton<AddCategoryUseCase>(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton<AddProductUseCase>(() => AddProductUseCase(sl()));
  sl.registerLazySingleton<UpdateDeliveryManUseCase>(
      () => UpdateDeliveryManUseCase(sl()));
  sl.registerLazySingleton<DeliveryManListingUseCase>(
      () => DeliveryManListingUseCase(sl()));
  sl.registerLazySingleton<UpdateStoreOfflineUseCase>(
      () => UpdateStoreOfflineUseCase(sl()));
  sl.registerLazySingleton<GetOrderDetailUseCase>(
      () => GetOrderDetailUseCase(sl()));
  sl.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton<GetOrderUseCase>(() => GetOrderUseCase(sl()));
  sl.registerLazySingleton<AddDeliveryManUseCase>(
      () => AddDeliveryManUseCase(sl()));
  sl.registerLazySingleton<GetCustomerUseCase>(() => GetCustomerUseCase(sl()));
  sl.registerLazySingleton<GetDeliveryManDetailUseCase>(
      () => GetDeliveryManDetailUseCase(sl()));
  sl.registerLazySingleton<UpdateCategoryUseCase>(
      () => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton<UpdateTimingUseCase>(
      () => UpdateTimingUseCase(sl()));
  sl.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(sl()));
  sl.registerLazySingleton<GetStoreTimingUseCase>(
      () => GetStoreTimingUseCase(sl()));
  sl.registerLazySingleton<DeleteCategoryUseCase>(
      () => DeleteCategoryUseCase(sl()));
  sl.registerLazySingleton<GetProductDetailsUseCase>(
      () => GetProductDetailsUseCase(sl()));
  sl.registerLazySingleton<EditOrderUseCase>(() => EditOrderUseCase(sl()));
  sl.registerLazySingleton<GetDashBoardUseCase>(
      () => GetDashBoardUseCase(sl()));
  sl.registerLazySingleton<ChangeOrderStatusUseCase>(
      () => ChangeOrderStatusUseCase(sl()));
  sl.registerLazySingleton<ProductStatusUpdateUseCase>(
      () => ProductStatusUpdateUseCase(sl()));
  sl.registerLazySingleton<ChangeAccountDetailUseCase>(
      () => ChangeAccountDetailUseCase(sl()));
  //bloc providers
  sl.registerLazySingleton<BottomNavigationCubit>(
      () => BottomNavigationCubit());
  sl.registerLazySingleton<ProductBloc>(
      () => ProductBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<VariantBloc>(() => VariantBloc());
  sl.registerLazySingleton<CategoryBloc>(
      () => CategoryBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<OrderBloc>(() => OrderBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<StoreTimingCubit>(
      () => StoreTimingCubit(sl(), sl()));
  sl.registerLazySingleton<DashboardBloc>(() => DashboardBloc(sl(), sl()));
  sl.registerLazySingleton<DeliveryManBloc>(
      () => DeliveryManBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<CustomerBloc>(() => CustomerBloc(sl()));

  //adapters
  Hive.registerAdapter(CategoryIdAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(StatusModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(StoreTimingModelAdapter());
  // Hive.registerAdapter(SubCategoryModelAdapter());
  Hive.registerAdapter(TagModelAdapter());
  Hive.registerAdapter(UnitModelAdapter());
}

extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
