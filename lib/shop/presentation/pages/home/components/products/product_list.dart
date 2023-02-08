import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/app_constants.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductBloc controller;
  final scrollController = ScrollController();

  emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 143,
          height: 130,
          child: Image.asset(
            AppAssets.productImg,
            fit: BoxFit.fill,
          ),
        ),
        spacer18,
        const Text(
          AppStrings.addProductDesc,
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: AppColors.black),
        ),
        spacer18,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            AppStrings.addProductDescSub,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
        ),
        // ShiningButton(
        //   title: AppStrings.addNewProduct,
        //   onTap: () => {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => const ProductForm()))
        //   },
        // ),
        // const SizedBox(
        //   height: 10,
        // )
      ],
    );
  }

  @override
  void initState() {
    controller = ProductBloc.get(context);
    controller.add(ProductFetchEvent(() {}, (p0) => {}, () {
      handleUnAuthorizedError(context);
    }));
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.add(const GetPaginatedProducts());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.clearTextFields();
            GoRouter.of(context).pushNamed(AppPages.addProduct);
          },
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        backgroundColor: AppColors.offWhite1,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductFetching && controller.productList.isEmpty) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        const ShimmerCategoryLoad()),
              );
            } else if (state is ProductFetchError) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (state.error == "session expired") {
                  handleUnAuthorizedError(context);
                } else {
                  handleError(context, state.error, () {
                    Navigator.pop(context);
                  });
                }
              });
            }
            return ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.productList.length + 1,
                itemBuilder: (context, index) =>
                    controller.productList.length == index
                        ? controller.currentPage < controller.lastPage
                            ? Shimmer.fromColors(
                                highlightColor: Colors.grey.shade100,
                                baseColor: Colors.grey.shade300,
                                child: const ShimmerCategoryLoad())
                            : Container()
                        : ProductListTile(
                            entity: controller.productList[index],
                            delete: () {
                              controller.add(DeleteProductEvent(
                                  context, controller.productList[index].id));
                            },
                          ));
          },
        ));
  }
}

class ProductListTile extends StatefulWidget {
  final ProductModel entity;
  final bool? adding;
  final Function delete;
  final Function? selectable;
  const ProductListTile(
      {Key? key,
      required this.entity,
      this.adding,
      required this.delete,
      this.selectable})
      : super(key: key);

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  late ValueNotifier<bool> _notifier;
  late ProductBloc _controller;

  @override
  void initState() {
    _notifier = ValueNotifier(widget.entity.status == 1 ? true : false);
    _controller = ProductBloc.get(context);
    super.initState();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: AppColors.offWhite1,
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer18,
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 82,
                        height: 82,
                        decoration: BoxDecoration(
                            // color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.entity.image,
                            errorWidget: (n, j, q) =>
                                Image.asset(AppAssets.errorImage),
                            placeholder: (n, j) =>
                                Image.asset(AppAssets.errorImage),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.entity.name,
                              style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            spacer10,
                            widget.entity.stock == null
                                ? const SizedBox()
                                : widget.entity.stock == 0
                                    ? const Text(
                                        "Out of stock",
                                        style: TextStyle(
                                            color: AppColors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const Text(
                                        "In stock",
                                        style: TextStyle(
                                            color: AppColors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                            Row(
                              children: [
                                Text(
                                  "${(widget.entity.price ?? "")}",
                                  style: const TextStyle(
                                      color: AppColors.offWhiteTextColor,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${((widget.entity.price ?? 0.0) - (widget.entity.discount ?? 0.0) ?? "")}",
                                  style: const TextStyle(
                                      color: AppColors.black,
                                      // decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            spacer9,
                          ],
                        ),
                      ),
                      widget.adding == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                spacer20,
                                spacer30,
                                InkWell(
                                  onTap: widget.selectable == null
                                      ? null
                                      : () => widget.selectable!(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 2),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.skyBlue),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      AppStrings.add,
                                      style: TextStyle(
                                        color: AppColors.skyBlue,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PopupMenuButton<int>(
                                    icon: Image.asset(
                                      AppAssets.menu,
                                      width: 20,
                                      height: 20,
                                    ),
                                    onSelected: (val) {
                                      switch (val) {
                                        case 1:
                                          GoRouter.of(context).pushNamed(
                                              AppPages.editProduct,
                                              params: {
                                                'id':
                                                    widget.entity.id.toString()
                                              });
                                          break;
                                        case 2:
                                          widget.delete();

                                          break;
                                      }
                                    },
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppAssets.edit,
                                                  width: 15,
                                                  height: 15,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                const Text(
                                                  AppStrings.edit,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color: AppColors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                          // PopupMenuItem(
                                          //   child: Row(
                                          //     children: [
                                          //       Image.asset(
                                          //         AppAssets.moveTop,
                                          //         width: 15,
                                          //         height: 15,
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //       const SizedBox(
                                          //         width: 12,
                                          //       ),
                                          //       const Text(
                                          //         AppStrings.moveTop,
                                          //         style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.w600,
                                          //             fontSize: 15,
                                          //             color: AppColors.black),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    AppAssets.delete,
                                                    width: 15,
                                                    height: 15,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  const Text(
                                                    AppStrings.delete,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: AppColors.pink),
                                                  )
                                                ],
                                              )),
                                        ]),

                                // const Spacer(),
                                // ValueListenableBuilder(
                                //     valueListenable: _notifier,
                                //     builder: (context, val, child) {
                                //       return CustomSwitch(
                                //         value: val,
                                //         enableColor: AppColors.green,
                                //         disableColor: AppColors.brown,
                                //         onChanged: (value) {
                                //           _notifier.value = !_notifier.value;
                                //           _controller.add(
                                //               ChangeProductStatusEvent(
                                //                   params:
                                //                       ProductStatusRequestParams(
                                //                           id:
                                //                               widget
                                //                                   .entity.id
                                //                                   .toString(),
                                //                           status:
                                //                               _notifier.value
                                //                                   ? 1
                                //                                   : 0),
                                //                   context: context));
                                //
                                //           // _notifier.notifyListeners();
                                //         },
                                //         height: 27,
                                //         width: 51,
                                //       );
                                //     })
                              ],
                            )
                    ],
                  ),
                ),
                // spacer10,
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Divider(),
                // ),
                // spacer10,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       AppAssets.sharedFilled,
                //       width: 20,
                //       height: 20,
                //     ),
                //     SizedBox(
                //       width: 8,
                //     ),
                //     const Text(
                //       AppStrings.share,
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.skyBlue),
                //     ),
                //   ],
                // ),
                spacer18,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
