import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/pretty_printer.dart';
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
import 'package:shop_app/shop/presentation/routes/route_manager.dart';
import 'package:shop_app/shop/presentation/themes/themes.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import 'injector.dart';

class ShopApp extends StatefulWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  getToken() async {
    prettyPrint(await FirebaseMessaging.instance.getToken());
  }

  @override
  void initState() {
    // getToken();
    super.initState();
  }

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
        BlocProvider<LoginBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<StoreTimingCubit>(
          create: (context) => sl(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<CustomerBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<DeliveryManBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: data.textScaleFactor * (1)),
            child: child ?? const SizedBox(),
          );
        },
        theme: AppTheme.getTheme(),
        title: AppConstants.appName,
        routerConfig: AppRouteManager.appRoutes,
      ),
    );
  }
}
