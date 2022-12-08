import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/product_list.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../widgets/custom_app_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProductBloc prodController;
  late CategoryBloc catController;

  @override
  void initState() {
    prodController = ProductBloc.get(context);
    catController = CategoryBloc.get(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        prettyPrint("index changing");
        prodController.changeTabIndex(_tabController.index);
        // controller.add(TabIndexChangingEvent(_tabController.index));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 70),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is TabIndexState) {
              return getAppBar(
                  context,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      state.index == 0
                          ? Container()
                          : GestureDetector(
                              onTap: (() {
                                GoRouter.of(context)
                                    .pushNamed(AppPages.reOrder);
                              }),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Image.asset(
                                  AppAssets.reorder,
                                  width: 20,
                                  height: 20,
                                ),
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
                        child: GestureDetector(
                          onTap: () {
                            prodController
                                .add(SearchProductTapEvent(state.index));
                          },
                          child: Image.asset(
                            AppAssets.search,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  height: 220);
            } else if (state is SearchProductTap) {
              return getAppBar(
                  context,
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller:
                                    prodController.searchCategoryController,
                                decoration: const InputDecoration(
                                    hintText: "Search ... "),
                                onFieldSubmitted: (val) {
                                  prodController.add(ProductSearchEvent(
                                      searchKey: val,
                                      unAuthorized: () {
                                        handleUnAuthorizedError(context);
                                      }));
                                },
                              ),
                            ),
                          )),
                      Expanded(
                        child: Row(children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              AppAssets.search,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                prodController.add(ProductInitialEvent());
                              },
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.black,
                                size: 30,
                              )),
                        ]),
                      )
                    ],
                  ));
            }
            return getAppBar(
                context,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.catalogue,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          prodController.add(const SearchProductTapEvent(0));
                        },
                        child: Image.asset(
                          AppAssets.search,
                          width: 20,
                          height: 20,
                        ),
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
          TabBar(
              controller: _tabController,
              labelColor: AppColors.black,
              indicatorColor: AppColors.primaryColor,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              tabs: const [
                Tab(
                  text: AppStrings.products,
                ),
                Tab(
                  text: AppStrings.categories,
                ),
              ]),
          spacer10,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProductList(),
                CategoryList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
