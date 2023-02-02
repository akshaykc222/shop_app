import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/routes/hive_storage_name.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/customer_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/delivery_man_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/deliveryman_add.dart';
import 'package:shop_app/shop/presentation/pages/home/components/manage_store/components/store_timing_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/components/add_product.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/components/order_detail.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_form.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/sub_category.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/tag_list_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/login/login_screen.dart';

import '../../data/models/category_response.dart';
import '../../domain/entities/category_entity.dart';
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
          String? token = storage.read(LocalStorageNames.token);
          if (token == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen(currentIndex: 0);
          }
        },
      ),
      GoRoute(
        name: AppPages.login,
        path: "/${AppPages.login}",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: AppPages.editProduct,
        path: "/${AppPages.editProduct}/:id",
        builder: (BuildContext context, GoRouterState state) {
          if (state.params.containsKey('id')) {
            return ProductForm(
              id: int.parse(state.params['id'] ?? "0"),
            );
          }
          return const SizedBox();
        },
      ),
      GoRoute(
        name: AppPages.addProduct,
        path: "/${AppPages.addProduct}",
        builder: (BuildContext context, GoRouterState state) {
          return const ProductForm();
        },
      ),
      GoRoute(
        name: AppPages.editCategory,
        path: "/${AppPages.editCategory}/:model",
        builder: (BuildContext context, GoRouterState state) {
          String? json = state.params['model'];
          if (json != null || json != "") {
            CategoryEntity? model = CategoryModel.fromJson(jsonDecode(json!));
            return CategoryAddForm(
              entity: model,
            );
          }
          return const CategoryAddForm();
        },
      ),
      GoRoute(
        name: AppPages.addCategory,
        path: "/${AppPages.addCategory}",
        builder: (BuildContext context, GoRouterState state) {
          // String? json = state.p;
          // if (json != null || json != "") {
          //   CategoryEntity? model = CategoryModel.fromJson(jsonDecode(json!));
          //   return CategoryAddForm(
          //     entity: model,
          //   );
          // }
          return const CategoryAddForm();
        },
      ),
      GoRoute(
        name: AppPages.subCategory,
        path: "/${AppPages.subCategory}/:model",
        builder: (BuildContext context, GoRouterState state) {
          String? json = state.params['model'];
          if (json != null || json != "") {
            CategoryEntity? model = CategoryModel.fromJson(jsonDecode(json!));
            return SubCategoryScreen(
              categoryEntity: model,
            );
          }
          return const SizedBox();
        },
      ),
      GoRoute(
        name: AppPages.detail,
        path: "/${AppPages.detail}/:id",
        builder: (BuildContext context, GoRouterState state) {
          String? id = state.params['id'];
          if (id != null) {
            return OrderDetails(id: id);
          }
          return const SizedBox();
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
        name: AppPages.tagSelect,
        path: "/${AppPages.tagSelect}",
        builder: (BuildContext context, GoRouterState state) {
          return const TagListScreen();
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
      GoRoute(
        name: AppPages.deliverymanEdit,
        path: "/${AppPages.deliverymanEdit}/:id",
        builder: (BuildContext context, GoRouterState state) {
          var param = state.params["id"];
          if (param == null) {
            throw "Model required";
          }
          return DeliveryManAdding(id: int.parse(param));
        },
      ),
      GoRoute(path: home(), builder: _homePageRouteBuilder)
    ],
  );
}
