import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/routes/hive_storage_name.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

import '../manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import '../routes/route_manager.dart';
import '../themes/app_assets.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(LocalStorageNames.type) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 77,
          decoration: BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, -1),
            )
          ]),
          child: BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
            listener: (context, state) {},
            builder: (context, state) {
              prettyPrint("rebuilding");
              var cubit = BottomNavigationCubit.get(context);
              return FutureBuilder(
                  future: getType(),
                  builder: (context, data) {
                    return data.hasData
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: data.data == true
                                ? (DeliverManNavigationItems.values)
                                    .map(
                                      (menu) => Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkResponse(
                                            splashFactory:
                                                InkRipple.splashFactory,
                                            radius: 30,
                                            splashColor: Colors.black12,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              cubit.changeBottomNav(menu.index);
                                              GoRouter.of(context).go(
                                                  AppRouteManager.home(
                                                      CustomBottomNavigationItems
                                                          .values[menu.index]));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  getHomeIconDel(menu),
                                                  color: cubit.currentIndex !=
                                                          menu.index
                                                      ? Colors.grey
                                                      : AppColors.primaryColor,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                // const SizedBox(
                                                //   height: 3,
                                                // ),
                                                // Text(
                                                //   "${menu.name[0].toUpperCase()}${menu.name.substring(1)}",
                                                //   style: TextStyle(
                                                //     fontSize: 12,
                                                //     color: cubit.currentIndex != menu.index
                                                //         ? Colors.grey
                                                //         : Colors.blue.withOpacity(0.7),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                                : (CustomBottomNavigationItems.values)
                                    .map(
                                      (menu) => Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkResponse(
                                            splashFactory:
                                                InkRipple.splashFactory,
                                            radius: 30,
                                            splashColor: Colors.black12,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              cubit.changeBottomNav(menu.index);
                                              GoRouter.of(context).go(
                                                  AppRouteManager.home(
                                                      CustomBottomNavigationItems
                                                          .values[menu.index]));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  getHomeIcon(menu),
                                                  color: cubit.currentIndex !=
                                                          menu.index
                                                      ? Colors.grey
                                                      : AppColors.primaryColor,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                // const SizedBox(
                                                //   height: 3,
                                                // ),
                                                // Text(
                                                //   "${menu.name[0].toUpperCase()}${menu.name.substring(1)}",
                                                //   style: TextStyle(
                                                //     fontSize: 12,
                                                //     color: cubit.currentIndex != menu.index
                                                //         ? Colors.grey
                                                //         : Colors.blue.withOpacity(0.7),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList())
                        : const SizedBox();
                  });
            },
          ),
        ),
      ],
    );
    ;
  }
}

enum CustomBottomNavigationItems { home, orders, products, manage }

enum DeliverManNavigationItems {
  home,
  orders,
}

String getHomeIcon(CustomBottomNavigationItems menu) {
  switch (menu) {
    case CustomBottomNavigationItems.home:
      return AppAssets.homeIcon;
    case CustomBottomNavigationItems.orders:
      return AppAssets.orderIcon;
    case CustomBottomNavigationItems.products:
      return AppAssets.productIcon;
    case CustomBottomNavigationItems.manage:
      return AppAssets.manageIcon;
    // case CustomBottomNavigationItems.account:
    //   return AppAssets.userIcon;
  }
}

String getHomeIconDel(DeliverManNavigationItems menu) {
  switch (menu) {
    case DeliverManNavigationItems.orders:
      return AppAssets.orderIcon;

    // case DeliverManNavigationItems.account:
    //   return AppAssets.userIcon;
    case DeliverManNavigationItems.home:
      return AppAssets.homeIcon;
  }
}
