import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/customer_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/delivery_man_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/deliveryman_add.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/components/add_product.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_form.dart';
import 'package:shop_app/shop/presentation/pages/home/components/profile/components/store_timing_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/login/login_screen.dart';

import '../pages/home/components/products/product_form.dart';
import '../pages/home/components/products/reorderable.dart';
import '../pages/home/components/products/variant_screen.dart';
import '../pages/home/home_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'app_pages.dart';

class AppRouteManager {
  static home([CustomBottomNavigationItems? type]) =>
      '/${type?.index ?? ':type'}';
  static Widget _homePageRouteBuilder(
      BuildContext context, GoRouterState state) {
    prettyPrint(state.params['type']);
    return HomeScreen(
      currentIndex: int.parse(state.params['type']!),
    );
  }

  static GoRouter appRoutes = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: AppPages.initial,
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          var storage = GetStorage();
          String? token = storage.read('token');
          if (token == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen(currentIndex: 0);
          }
        },
      ),
      GoRoute(
        name: AppPages.addProduct,
        path: "/add_product",
        builder: (BuildContext context, GoRouterState state) {
          return const ProductForm();
        },
      ),
      GoRoute(
        name: AppPages.addCategory,
        path: "/${AppPages.addCategory}",
        builder: (BuildContext context, GoRouterState state) {
          return const CategoryAddForm();
        },
      ),
      GoRoute(
        name: AppPages.addVariant,
        path: "/${AppPages.addVariant}",
        builder: (BuildContext context, GoRouterState state) {
          return const VariantScreen();
        },
      ),
      GoRoute(
        name: AppPages.reOrder,
        path: "/${AppPages.reOrder}",
        builder: (BuildContext context, GoRouterState state) {
          return const ReOrderableListCategoryScreen();
        },
      ),
      GoRoute(
        name: AppPages.customerList,
        path: "/${AppPages.customerList}",
        builder: (BuildContext context, GoRouterState state) {
          return const CustomerList();
        },
      ),
      GoRoute(
        name: AppPages.addNewOrderProduct,
        path: "/${AppPages.addNewOrderProduct}",
        builder: (BuildContext context, GoRouterState state) {
          return const AddOrderProductScreen();
        },
      ),
      GoRoute(
        name: AppPages.storeTiming,
        path: "/${AppPages.storeTiming}",
        builder: (BuildContext context, GoRouterState state) {
          return const StoreTimingScreen();
        },
      ),
      GoRoute(
        name: AppPages.deliveryman,
        path: "/${AppPages.deliveryman}",
        builder: (BuildContext context, GoRouterState state) {
          return const DeliveryManList();
        },
      ),
      GoRoute(
        name: AppPages.deliverymanAdd,
        path: "/${AppPages.deliverymanAdd}",
        builder: (BuildContext context, GoRouterState state) {
          return const DeliveryManAdding();
        },
      ),
      GoRoute(path: home(), builder: _homePageRouteBuilder)
    ],
  );
}
