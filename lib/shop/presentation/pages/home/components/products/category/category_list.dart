import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';

import '../../../../../../domain/entities/category_entity.dart';
import '../../../../../themes/app_assets.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_strings.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../widgets/custom_switch.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with WidgetsBindingObserver {
  var scrollController = ScrollController();
  late CategoryBloc controller;

  @override
  void initState() {
    controller = CategoryBloc.get(context);
    controller.add(GetCategoryEvent());
    scrollController.addListener(pagination);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.getPaginatedResponse();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    prettyPrint("state is ${state.name}");
  }

  emptyList() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [],
          ),
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
            "No categories found",
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
          spacer18,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
          //   child: Text(
          //     AppStrings.addProductDescSub,
          //     textAlign: TextAlign.center,
          //     style:
          //     Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
          //   ),
          // ),
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
      ),
    );
  }

  @override
  void didChangeDependencies() {
    prettyPrint("stat is wrking");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearTextFields();
          GoRouter.of(context).pushNamed(
            AppPages.addCategory,
          );
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) => const ShimmerCategoryLoad());
          } else if (state is CategoryErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              handleError(context, state.error, () => Navigator.pop(context));
            });
          } else if (state is CategoryDeletedState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Deleted")));
            });
          }
          return controller.categoryList.isEmpty
              ? emptyList()
              : ListView.builder(
                  itemCount: controller.categoryList.length + 1,
                  shrinkWrap: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      controller.categoryList.length == index
                          ? controller.currentPage < controller.totalPage
                              ? const ShimmerCategoryLoad()
                              : Container()
                          : CategoryListTile(
                              entity: controller.categoryList[index],
                              edit: () {},
                              delete: () {
                                controller.add(DeleteCategoryEvent(
                                    context: context,
                                    id: int.parse(
                                        controller.categoryList[index].id)));
                              },
                            ));
        },
      ),
    );
  }
}

class CategoryListTile extends StatefulWidget {
  final CategoryEntity entity;
  final bool? reOrder;
  final Function edit;
  final bool? selectable;
  final Function? select;
  final Function delete;
  const CategoryListTile(
      {super.key,
      required this.entity,
      this.reOrder,
      required this.edit,
      required this.delete,
      this.selectable,
      this.select});

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  late ValueNotifier<bool> _notifier;
  late CategoryBloc controller;

  @override
  void initState() {
    controller = CategoryBloc.get(context);
    _notifier = ValueNotifier(widget.entity.status);
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
      child: GestureDetector(
        onTap: () {
          if (widget.selectable == true) {
            widget.select!();
          } else {
            GoRouter.of(context).pushNamed(AppPages.subCategory,
                params: {'model': jsonEncode(widget.entity.toJson())});
          }
        },
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.offWhite1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 20, top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Container(
                                  width: 82,
                                  height: 82,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.entity.image,
                                      errorWidget: (context, error, child) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                            color: AppColors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    spacer22,
                                    Text(
                                      widget.entity.name,
                                      style: const TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    spacer10,
                                    Text(
                                      "${widget.entity.productCount} product listed",
                                      style: const TextStyle(
                                          color: AppColors.offWhiteTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    spacer9,
                                    // const Text(
                                    //   "Active",
                                    //   style: TextStyle(
                                    //       color: AppColors.green,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w600),
                                    // )
                                  ],
                                ),
                              ),
                              widget.selectable == true
                                  ? Container()
                                  : Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          spacer37,

                                          // const Spacer(),
                                          ValueListenableBuilder(
                                              valueListenable: _notifier,
                                              builder:
                                                  (context, bool val, child) {
                                                prettyPrint(
                                                    "widget rebuilding $val");
                                                return CustomSwitch(
                                                  value: val,
                                                  enableColor: AppColors.green,
                                                  disableColor: AppColors.brown,
                                                  onChanged: (value) {
                                                    _notifier.value =
                                                        !_notifier.value;
                                                    _notifier.notifyListeners();
                                                  },
                                                  height: 27,
                                                  width: 51,
                                                );
                                              })
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                        spacer20,
                      ],
                    ),
                  ),
                  widget.selectable == true
                      ? Container()
                      : Positioned(
                          top: 2,
                          right: 2,
                          child: PopupMenuButton<int>(
                              onSelected: (val) {
                                switch (val) {
                                  case 1:
                                    GoRouter.of(context).pushNamed(
                                        AppPages.editCategory,
                                        params: {
                                          'model':
                                              jsonEncode(widget.entity.toJson())
                                        });
                                    break;
                                  case 3:
                                    widget.delete();
                                    break;
                                  default:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("default !")));
                                }
                              },
                              icon: Image.asset(
                                AppAssets.menu,
                                width: 20,
                                height: 20,
                              ),
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.moveTop,
                                            width: 15,
                                            height: 15,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          const Text(
                                            AppStrings.moveTop,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: AppColors.pink),
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                        )
                ],
              ),
            ),
            widget.reOrder == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.ordering,
                          width: 20,
                          height: 20,
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class ShimmerCategoryLoad extends StatelessWidget {
  const ShimmerCategoryLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.offWhite1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 20, top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.red,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 82,
                                    height: 82,
                                    decoration: BoxDecoration(
                                        color: AppColors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    spacer22,
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: const SizedBox(
                                        width: 150,
                                        height: 10,
                                      ),
                                    ),
                                    spacer10,
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const SizedBox(
                                          width: 150,
                                          height: 10,
                                        )),
                                    spacer9,
                                    // const Text(
                                    //   "Active",
                                    //   style: TextStyle(
                                    //       color: AppColors.green,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w600),
                                    // )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    spacer37,

                                    // const Spacer(),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 40,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        spacer20,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
