import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/product_list.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../widgets/custom_app_bar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final controller = ProductBloc.get(context);
              return getAppBar(
                  context,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Image.asset(
                          AppAssets.reorder,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.catalogue,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Image.asset(
                          AppAssets.search,
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  ),
                  height: 220);
            },
          ),
        ),
        body: Column(
          children: [
            const TabBar(
                labelColor: AppColors.black,
                indicatorColor: AppColors.primaryColor,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                tabs: [
                  Tab(
                    text: AppStrings.products,
                  ),
                  Tab(
                    text: AppStrings.categories,
                  ),
                ]),
            spacer10,
            const Expanded(
              child: TabBarView(
                children: [
                  ProductList(),
                  CategoryList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
