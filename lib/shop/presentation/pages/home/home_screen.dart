import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/pages/home/components/dashboard/dashboard_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/order_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/products_main.dart';
import 'package:shop_app/shop/presentation/pages/home/components/profile/profile_view.dart';

import '../../widgets/bottom_navigation_bar.dart';
import 'components/manage_store/manage_store_screen.dart';

class HomeScreen extends StatelessWidget {
  final int currentIndex;
  const HomeScreen({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const homeItems = [
      DashBoardScreen(),
      OrderScreen(),
      ProductScreen(),
      ManageStoreScreen(),
      ProfileView(),
    ];
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: homeItems[currentIndex],
    );
  }
}
