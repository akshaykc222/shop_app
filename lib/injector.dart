import 'package:get_it/get_it.dart';
import 'package:shop_app/shop/presentation/manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';

import '../core/api_provider.dart';
import '../core/hive_service.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<HiveService>(() => HiveService());

  //bloc providers
  sl.registerLazySingleton<BottomNavigationCubit>(
      () => BottomNavigationCubit());
  sl.registerLazySingleton<ProductBloc>(() => ProductBloc());
  sl.registerLazySingleton<VariantBloc>(() => VariantBloc());
}
