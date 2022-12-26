import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/product_list.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_app_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  late ProductBloc prodController;
  late CategoryBloc catController;
  late ValueNotifier<int> tabValueNotifier;
  late ValueNotifier<bool> showSearchNotifier;
  late Animation expandingAnimation, transformAnimation, colorAnimation;
  late AnimationController expandingAnimationController;

  @override
  void initState() {
    prodController = ProductBloc.get(context);
    catController = CategoryBloc.get(context);
    _tabController = TabController(length: 2, vsync: this);

    tabValueNotifier = ValueNotifier(_tabController.index);
    showSearchNotifier = ValueNotifier(false);
    WidgetsBinding.instance.addObserver(this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        showSearchNotifier.value = false;
        prodController.searchCategoryController.clear();
        tabValueNotifier.value = _tabController.index;
        // controller.add(TabIndexChangingEvent(_tabController.index));
      }
    });
    super.initState();
  }

  // addAnimationListenerExpanding(){
  //   expandingAnimationController.addListener(() {
  //     if(expandingAnimation.isCompleted){
  //
  //     }
  //   });
  // }
  @override
  void didChangeDependencies() {
    expandingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    expandingAnimation =
        Tween<double>(begin: 50, end: MediaQuery.of(context).size.width)
            .animate(CurvedAnimation(
                parent: expandingAnimationController, curve: Curves.easeInBack))
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward) {
            } else if (status == AnimationStatus.reverse) {}
          });
    transformAnimation = BorderRadiusTween(
            begin: const BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            end: const BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0)))
        .animate(CurvedAnimation(
            parent: expandingAnimationController, curve: Curves.easeIn));
    colorAnimation =
        ColorTween(begin: AppColors.primaryColor, end: AppColors.white).animate(
            CurvedAnimation(
                parent: expandingAnimationController, curve: Curves.easeIn));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabValueNotifier.dispose();
    showSearchNotifier.dispose();
    expandingAnimationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 70),
        child: AnimatedBuilder(
          animation: expandingAnimationController,
          builder: (BuildContext context, Widget? child) {
            return ValueListenableBuilder(
                valueListenable: showSearchNotifier,
                builder: (context, search, child) {
                  return ValueListenableBuilder(
                      valueListenable: tabValueNotifier,
                      builder: (context, tabIndex, child) {
                        return !showSearchNotifier.value
                            ? getAppBar(
                                context,
                                Row(
                                  children: [
                                    Expanded(
                                      child: tabValueNotifier.value == 0
                                          ? Container()
                                          : GestureDetector(
                                              onTap: (() {
                                                GoRouter.of(context).pushNamed(
                                                    AppPages.reOrder);
                                              }),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0),
                                                child: Image.asset(
                                                  AppAssets.reorder,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppStrings.catalogue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          showSearchNotifier.value =
                                              !showSearchNotifier.value;
                                          expandingAnimationController
                                              .forward();
                                        },
                                        icon: Image.asset(
                                          AppAssets.search,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                height: 220)
                            : getAppBar(
                                context,
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: expandingAnimation.value,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: colorAnimation.value,
                                        borderRadius: transformAnimation.value,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: expandingAnimation.value <
                                                      200
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: SizedBox(
                                                        height: 55,
                                                        child: TextFormField(
                                                          controller: prodController
                                                              .searchCategoryController,
                                                          decoration: const InputDecoration(
                                                              hintText:
                                                                  "Search ... ",
                                                              border:
                                                                  UnderlineInputBorder()),
                                                          onFieldSubmitted:
                                                              (val) {
                                                            prodController.add(
                                                                ProductSearchEvent(
                                                                    searchKey:
                                                                        val,
                                                                    unAuthorized:
                                                                        () {
                                                                      handleUnAuthorizedError(
                                                                          context);
                                                                    }));
                                                          },
                                                        ),
                                                      ),
                                                    )),
                                          Expanded(
                                            child: Row(children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (tabValueNotifier.value ==
                                                      0) {
                                                    prodController.add(
                                                        ProductSearchEvent(
                                                            searchKey:
                                                                prodController
                                                                    .searchCategoryController
                                                                    .text,
                                                            unAuthorized:
                                                                () {}));
                                                  } else {
                                                    catController.add(
                                                        CategorySearchEvent(
                                                            prodController
                                                                .searchCategoryController
                                                                .text));
                                                  }
                                                },
                                                icon: Image.asset(
                                                  AppAssets.search,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    expandingAnimationController
                                                        .reverse()
                                                        .then((value) =>
                                                            showSearchNotifier
                                                                    .value =
                                                                !showSearchNotifier
                                                                    .value);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: AppColors.black,
                                                    size: 25,
                                                  )),
                                            ]),
                                          )
                                        ],
                                      ),
                                    )));
                      });
                });
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
