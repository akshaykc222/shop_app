import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/core/pretty_printer.dart';

import '../manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import '../themes/app_assets.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(color: Colors.white70, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 4,
          blurRadius: 5,
          offset: const Offset(0, -1),
        )
      ]),
      child: BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
        listener: (context, state) {},
        builder: (context, state) {
          prettyPrint("rebuilding");
          var cubit = BottomNavigationCubit.get(context);
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: CustomBottomNavigationItems.values
                  .map(
                    (menu) => Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkResponse(
                          splashFactory: InkRipple.splashFactory,
                          radius: 30,
                          splashColor: Colors.black12,
                          highlightColor: Colors.transparent,
                          onTap: () => cubit.changeBottomNav(menu.index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                getHomeIcon(menu),
                                color: cubit.currentIndex != menu.index
                                    ? Colors.grey
                                    : Colors.blue.withOpacity(0.7),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${menu.name[0].toUpperCase()}${menu.name.substring(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: cubit.currentIndex != menu.index
                                      ? Colors.grey
                                      : Colors.blue.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList());
        },
      ),
    );
  }
}

enum CustomBottomNavigationItems { home, orders, products, manage, account }

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
    case CustomBottomNavigationItems.account:
      return AppAssets.userIcon;
  }
}
