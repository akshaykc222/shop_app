import 'package:get_it/get_it.dart';
import 'package:shop_app/shop/data/data_sources/remote/auth_data_source.dart';
import 'package:shop_app/shop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:shop_app/shop/data/repositories/auth_remote_data_rempository_impl.dart';
import 'package:shop_app/shop/data/repositories/product_repository_impl.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';
import 'package:shop_app/shop/domain/use_cases/category_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/login_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/product_use_case.dart';
import 'package:shop_app/shop/presentation/manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/login_bloc/login_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/hour_tile_cubit/cubit/store_timing_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';

import '../core/api_provider.dart';
import '../core/hive_service.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<HiveService>(() => HiveService());
  //data source
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()));

  //repository'
  sl.registerLazySingleton<AuthRemoteDataRepository>(
      () => AuthRemoteDataRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));
  //use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<CategoryUseCase>(() => CategoryUseCaseImpl(sl()));
  sl.registerLazySingleton<ProductUseCase>(() => ProductUseCase(sl()));
  //bloc providers
  sl.registerLazySingleton<BottomNavigationCubit>(
      () => BottomNavigationCubit());
  sl.registerLazySingleton<ProductBloc>(() => ProductBloc(sl()));
  sl.registerLazySingleton<VariantBloc>(() => VariantBloc());
  sl.registerLazySingleton<CategoryBloc>(() => CategoryBloc(sl()));
  sl.registerLazySingleton<OrderBloc>(() => OrderBloc());
  sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl()));
  sl.registerLazySingleton<StoreTimingCubit>(() => StoreTimingCubit());
}
