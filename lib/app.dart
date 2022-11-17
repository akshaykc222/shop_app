import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';
import 'package:shop_app/shop/presentation/routes/route_manager.dart';
import 'package:shop_app/shop/presentation/themes/themes.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import 'injector.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (context) => sl(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<VariantBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.getTheme(),
        title: AppConstants.appName,
        routerConfig: AppRouteManager.appRoutes,
      ),
    );
  }
}
