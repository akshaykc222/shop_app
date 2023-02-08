import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/pretty_printer.dart';
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
import 'package:shop_app/shop/presentation/pages/splash_screen.dart';

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
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
        // builder: (BuildContext context, GoRouterState state) {
        //   var storage = GetStorage();
        //   String? token = storage.read(LocalStorageNames.token);
        //   if (token == null) {
        //     return const LoginScreen();
        //   } else {
        //     return const HomeScreen(currentIndex: 0);
        //   }
        // },
      ),
      GoRoute(
        name: AppPages.login,
        path: "/${AppPages.login}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // return ScaleTransition(
              //   scale: CurveTween(curve: Curves.slowMiddle).animate(animation),
              //   child: child,
              // );
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.home,
        path: "/${AppPages.home}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(currentIndex: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.editProduct,
        path: "/${AppPages.editProduct}/:id",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductForm(
              id: int.parse(state.params['id'] ?? "0"),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.addProduct,
        path: "/${AppPages.addProduct}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const ProductForm(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.editCategory,
        path: "/${AppPages.editCategory}/:model",
        pageBuilder: (context, state) {
          String? json = state.params['model'];
          CategoryEntity? model = CategoryModel.fromJson(jsonDecode(json!));
          return CustomTransitionPage(
            key: state.pageKey,
            child: CategoryAddForm(
              entity: model,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.addCategory,
        path: "/${AppPages.addCategory}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const CategoryAddForm(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.subCategory,
        path: "/${AppPages.subCategory}/:model",
        pageBuilder: (context, state) {
          String? json = state.params['model'];
          CategoryEntity? model = CategoryModel.fromJson(jsonDecode(json!));
          return CustomTransitionPage(
            key: state.pageKey,
            child: SubCategoryScreen(
              categoryEntity: model,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.detail,
        path: "/${AppPages.detail}/:id",
        pageBuilder: (context, state) {
          String? id = state.params['id'];
          return CustomTransitionPage(
            key: state.pageKey,
            child: OrderDetails(id: id!),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.addVariant,
        path: "/${AppPages.addVariant}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const VariantScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.reOrder,
        path: "/${AppPages.reOrder}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const ReOrderableListCategoryScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.tagSelect,
        path: "/${AppPages.tagSelect}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const TagListScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.customerList,
        path: "/${AppPages.customerList}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const CustomerList(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.addNewOrderProduct,
        path: "/${AppPages.addNewOrderProduct}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AddOrderProductScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.storeTiming,
        path: "/${AppPages.storeTiming}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const StoreTimingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.deliveryman,
        path: "/${AppPages.deliveryman}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const DeliveryManList(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.deliverymanAdd,
        path: "/${AppPages.deliverymanAdd}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const DeliveryManAdding(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(
        name: AppPages.deliverymanEdit,
        path: "/${AppPages.deliverymanEdit}/:id",
        pageBuilder: (context, state) {
          var param = state.params["id"];
          return CustomTransitionPage(
            key: state.pageKey,
            child: DeliveryManAdding(id: int.parse(param!)),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
              // return FadeTransition(
              //   opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              //   child: child,
              // );
            },
          );
        },
      ),
      GoRoute(path: home(), builder: _homePageRouteBuilder)
    ],
  );
}
