import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/order_screen.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/products_main.dart';

import '../../manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import '../../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeItems = [
      Container(),
      const OrderScreen(),
      const ProductScreen(),
      Container(),
      Container(),
    ];
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BottomNavigationCubit.get(context);
          return homeItems[cubit.currentIndex];
        },
      ),
    );
  }
}
