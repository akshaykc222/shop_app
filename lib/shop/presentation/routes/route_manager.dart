import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_form.dart';
import 'package:shop_app/shop/presentation/pages/home/home_screen.dart';

import 'app_pages.dart';

class AppRouteManager {
  static GoRouter appRoutes = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: AppPages.initial,
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: AppPages.addCategory,
        path: "/category",
        builder: (BuildContext context, GoRouterState state) {
          return const CategoryAddForm();
        },
      ),
    ],
  );
}
