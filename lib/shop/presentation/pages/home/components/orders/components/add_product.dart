import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../products/category/category_list.dart';
import '../../products/product_list.dart';

class AddOrderProductScreen extends StatefulWidget {
  const AddOrderProductScreen({super.key});

  @override
  State<AddOrderProductScreen> createState() => _AddOrderProductScreenState();
}

class _AddOrderProductScreenState extends State<AddOrderProductScreen>
    with TickerProviderStateMixin {
  late ProductBloc bloc;
  late OrderBloc orderBloc;
  final scrollController = ScrollController();
  ValueNotifier<bool> showSearchNotifier = ValueNotifier(false);
  late Animation expandingAnimation, transformAnimation, colorAnimation;
  late AnimationController expandingAnimationController;
  @override
  void initState() {
    bloc = ProductBloc.get(context);
    orderBloc = OrderBloc.get(context);
    bloc.add(ProductFetchEvent(() {}, (p0) => {}, () {
      handleUnAuthorizedError(context);
    }));
    scrollController.addListener(pagination);
    super.initState();
  }

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

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      bloc.add(const GetPaginatedProducts());
    }
  }

  final searchController = TextEditingController();
  final reasonForm = GlobalKey<FormState>();
  final reasonKey = TextEditingController();
  @override
  void dispose() {
    showSearchNotifier.dispose();
    expandingAnimationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductFetching && bloc.productList.isEmpty) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const ShimmerCategoryLoad()),
            );
          } else if (state is ProductFetchError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              handleError(context, state.error, () {
                Navigator.pop(context);
              });
            });
          }
          return ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: bloc.productList.length + 1,
              itemBuilder: (context, index) => bloc.productList.length == index
                  ? bloc.currentPage < bloc.lastPage
                      ? const ShimmerCategoryLoad()
                      : Container()
                  : ProductListTile(
                      entity: bloc.productList[index],
                      adding: true,
                      selectable: () {
                        orderBloc.addProduct(bloc.productList[index]);
                        // Navigator.pop(context);
                        GoRouter.of(context).pop();

                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return Wrap(
                        //         children: [
                        //           const Padding(
                        //             padding: EdgeInsets.symmetric(
                        //                 horizontal: 20.0, vertical: 25),
                        //             child: Text(
                        //               AppStrings.reasonForAddingProduct,
                        //               style: TextStyle(
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: const EdgeInsets.only(
                        //                 left: 20, right: 20, bottom: 20),
                        //             child: Form(
                        //                 key: reasonForm,
                        //                 child: TextFormField(
                        //                   controller: reasonKey,
                        //                 )),
                        //           ),
                        //           ElevatedButton(
                        //               onPressed: () {
                        //                 if (reasonForm.currentState!
                        //                     .validate()) {
                        //
                        //                 }
                        //               },
                        //               child: const Text(AppStrings.save))
                        //         ],
                        //       );
                        //     });
                      },
                      delete: () {
                        bloc.add(DeleteProductEvent(
                            context, bloc.productList[index].id));
                      },
                    ));
        },
      ),
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: AnimatedBuilder(
            animation: expandingAnimationController,
            builder: (context, child) {
              return ValueListenableBuilder(
                  valueListenable: showSearchNotifier,
                  builder: (context, search, child) {
                    return !showSearchNotifier.value
                        ? getAppBar(
                            context,
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: (() {
                                    GoRouter.of(context).pop();
                                  }),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                )),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        AppStrings.addProduct,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    )),
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    showSearchNotifier.value =
                                        !showSearchNotifier.value;
                                    expandingAnimationController.forward();
                                  },
                                  child: Image.asset(
                                    AppAssets.search,
                                    width: 23,
                                    height: 24,
                                  ),
                                ))
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
                                          child: expandingAnimation.value < 200
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: SizedBox(
                                                    height: 55,
                                                    child: TextFormField(
                                                      controller: bloc
                                                          .searchCategoryController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Search ... ",
                                                              border:
                                                                  UnderlineInputBorder()),
                                                      onFieldSubmitted: (val) {
                                                        bloc.add(
                                                            ProductSearchEvent(
                                                                searchKey: val,
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
                                            onPressed: () {},
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
            },
          )),
    );
  }
}
