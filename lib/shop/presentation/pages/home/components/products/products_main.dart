import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/product_list.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 100),
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final controller = ProductBloc.get(context);
              return AppBar(
                // backgroundColor: AppColors.primaryColor,
                // foregroundColor: AppColors.white,
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.add(SearchProductTapEvent());
                      },
                      icon: Icon(
                        controller.search ? Icons.close : Icons.search,
                        size: 30,
                      ))
                ],
                title: controller.search
                    ? const TextField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      )
                    : const Text(
                        AppStrings.catalogue,
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                bottom: const TabBar(
                    labelColor: AppColors.white,
                    indicatorColor: AppColors.white,
                    tabs: [
                      Tab(
                        text: AppStrings.products,
                      ),
                      Tab(
                        text: AppStrings.categories,
                      ),
                    ]),
              );
            },
          ),
        ),
        body: const TabBarView(
          children: [
            ProductList(),
            CategoryList(),
          ],
        ),
      ),
    );
  }
}
