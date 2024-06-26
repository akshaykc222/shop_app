import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';
import 'package:shop_app/shop/domain/entities/tag_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/utils/select_image_and_crop.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../data/models/category_request_model.dart';
import '../../../../../domain/entities/ProductEntity.dart';
import '../../../../themes/app_assets.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_switch.dart';

class ProductForm extends StatefulWidget {
  final int? id;
  const ProductForm({Key? key, this.id}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late ProductBloc controller;
  late CategoryBloc cateBloc;
  late VariantBloc variantBloc;
  var categoryScroll = ScrollController();
  ValueNotifier<String> imagePickerResult = ValueNotifier("");
  buildImageWidget() {
    return GestureDetector(
      onTap: () async {
        var result = await selectImageAndCropImage(
            context: context, title: AppStrings.uploadProductImage);
        if (result != null) {
          imagePickerResult.value = result.path ?? "";
          controller.image = result.path ?? "";
          imagePickerResult.notifyListeners();
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          prettyPrint("Current state is $state");
          return ValueListenableBuilder(
              valueListenable: imagePickerResult,
              builder: (context, val, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 38,
                    ),
                    Container(
                      width: 138,
                      height: 138,
                      decoration: BoxDecoration(
                          // color: AppColors.lightGrey,
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(19)),
                      child: (controller.image != "" ||
                                  controller.image != null) &&
                              controller.image
                                      ?.contains(AppRemoteRoutes.baseUrl) ==
                                  true
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(19),
                              child: CachedNetworkImage(
                                imageUrl: controller.image!,
                                fit: BoxFit.contain,
                              ),
                            )
                          : val != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(19),
                                  child: Image.file(File(val)))
                              : const Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Add Thumbnail",
                      style: TextStyle(
                          color: AppColors.skyBlue,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                );
              });
        },
      ),
    );
  }

  buildMoreImages() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'More Images : ',
                    style: TextStyle(
                        color: AppColors.greyText, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildTextFieldName() {
    return CommonTextField(
      controller: controller.productNameController,
      title: AppStrings.productName,
      validator: (val) {
        if (val.isEmpty) {
          return AppConstants.kProductNameError;
        } else if (val.length < 2) {
          return AppConstants.kProductValidNameError;
        }
      },
      required: true,
    );
  }

  buildTextFieldCategory() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 5,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      spacer20,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cateBloc.searchController,
                              decoration: const InputDecoration(
                                  hintText: "Search ... "),
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                cateBloc.add(CategorySearchEvent(
                                    cateBloc.searchController.text));
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                              ))
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return cateBloc.categoryList.isEmpty
                                ? const Center(
                                    child: Text("No Categories."),
                                  )
                                : ListView.builder(
                                    itemCount: cateBloc.categoryList.length + 1,
                                    shrinkWrap: true,
                                    controller: categoryScroll,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => cateBloc
                                                .categoryList.length ==
                                            index
                                        ? cateBloc.currentPage <
                                                    cateBloc.totalPage &&
                                                state
                                                    is CategoryLoadingMoreState
                                            ? Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child:
                                                    const ShimmerCategoryLoad())
                                            : Container()
                                        : CategoryListTile(
                                            entity:
                                                cateBloc.categoryList[index],
                                            edit: () {},
                                            selectable: true,
                                            select: () {
                                              controller.changeSelectedCategory(
                                                  cateBloc.categoryList[index]);
                                              cateBloc.add(GetSubCategoryEvent(
                                                  context: context,
                                                  request: CategoryRequestModel(
                                                      name: cateBloc
                                                              .categoryList[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      image: "",
                                                      parentId: 0)));
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context);
                                            },
                                            delete: () {},
                                          ));
                          },
                        ),
                      ),
                    ],
                  ),
                ));
      },
      child: CommonTextField(
        enable: false,
        controller: controller.categoryController,
        title: AppStrings.productCategory,
        required: true,
      ),
    );
  }

  buildTextFieldSubCategory() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 5,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      spacer20,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: cateBloc.searchController,
                              decoration: const InputDecoration(
                                  hintText: "Search ... "),
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                cateBloc.add(CategorySearchEvent(
                                    cateBloc.searchController.text));
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                              ))
                        ],
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          return Expanded(
                            child: cateBloc.subCategoryList.isEmpty
                                ? const Center(
                                    child: Text("No Subcategories"),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        cateBloc.subCategoryList.length + 1,
                                    shrinkWrap: true,
                                    controller: categoryScroll,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => cateBloc
                                                .subCategoryList.length ==
                                            index
                                        ? cateBloc.currentPage <
                                                    cateBloc.totalPage &&
                                                state
                                                    is CategoryLoadingMoreState
                                            ? Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child:
                                                    const ShimmerCategoryLoad())
                                            : Container()
                                        : CategoryListTile(
                                            entity:
                                                cateBloc.subCategoryList[index],
                                            edit: () {},
                                            selectable: true,
                                            select: () {
                                              controller
                                                  .changeSelectedSubCategory(
                                                      cateBloc.subCategoryList[
                                                          index]);
                                              Navigator.pop(context);
                                            },
                                            delete: () {},
                                          )),
                          );
                        },
                      ),
                    ],
                  ),
                ));
      },
      child: CommonTextField(
        enable: false,
        controller: controller.subCategoryController,
        title: AppStrings.subProductCategory,
        required: true,
      ),
    );
  }

  buildTypeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Wrap(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.chooseProductUnit,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              // padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      //outer spacing
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8, // space between items
                        children: controller.unitList
                            .map((e) => InkWell(
                                  onTap: () {
                                    controller.changeSelectedUnitEntity(e);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color:
                                                controller.selectedUnitEntity ==
                                                        e
                                                    ? AppColors.green
                                                    : AppColors.lightGrey,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          e.unit,
                                          style: TextStyle(
                                            color:
                                                controller.selectedUnitEntity ==
                                                        e
                                                    ? AppColors.green
                                                    : AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  buildTextPriceAndDiscountField() {
    return Row(
      children: [
        Expanded(
            child: CommonTextField(
          controller: controller.priceController,
          required: true,
          title: AppStrings.price,
          textInputType: const TextInputType.numberWithOptions(decimal: true),
          // prefix: Padding(
          //   padding: const EdgeInsets.only(top: 10.0, left: 4),
          //   child: FutureBuilder(
          //       // future: getUserData(),
          //       builder: (context, snap) {
          //     return const Text(
          //       "",
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     );
          //   }),
          // ),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: CommonTextField(
          controller: controller.discountPriceController,
          required: true,
          title: AppStrings.discountPrice,
          validator: (val) {
            if (controller.priceController.text.isNotEmpty &&
                controller.discountPriceController.text.isNotEmpty) {
              if (double.parse(controller.priceController.text) <
                  double.parse(controller.discountPriceController.text)) {
                return "Value is greater than actual price";
              }
            }
          },
          textInputType: const TextInputType.numberWithOptions(decimal: true),
          // prefix: Padding(
          //   padding: const EdgeInsets.only(top: 10.0, left: 4),
          //   child: FutureBuilder(
          //       // future: getUserData(),
          //       builder: (context, snap) {
          //     return const Text(
          //       "",
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     );
          //   }),
          // ),
        ))
      ],
    );
  }

  @override
  void initState() {
    controller = ProductBloc.get(context);
    if (widget.id != null) {
      controller.add(GetProductDetailsEvent(context, widget.id!));
    } else {
      controller.clearTextFields();
    }

    cateBloc = CategoryBloc.get(context);
    cateBloc.add(GetCategoryEvent());
    variantBloc = VariantBloc.get(context);
    // controller.add(GetUnitsEvent(context));
    categoryScroll.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (categoryScroll.position.pixels ==
        categoryScroll.position.maxScrollExtent) {
      cateBloc.getPaginatedResponse();
    }
  }

  _productForm() {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildImageWidget(),
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "More Images",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  spacer10,
                  SizedBox(
                    height: 80,
                    child: ValueListenableBuilder(
                      valueListenable: controller.moreImage,
                      builder: (context, data, child) {
                        return BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length + 1,
                                itemBuilder: (context, index) => index >=
                                            data.length ||
                                        data.isEmpty == true
                                    ? state is MoreProductImageLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              var data =
                                                  await selectImageAndCropImage(
                                                      context: context,
                                                      title: "Choose Image");
                                              if (data != null) {
                                                controller.add(
                                                    UploadMoreImagesEvent(
                                                        ImageEntity(
                                                            image: data.path)));
                                              }
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.greyText)),
                                              child: const Center(
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          )
                                    : FutureBuilder(
                                        future:
                                            isFilePath(data[index].image ?? ""),
                                        builder: (context, d) {
                                          return !d.hasData
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Container(
                                                  width: 80,
                                                  height: 80,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: d.data == true
                                                          ? DecorationImage(
                                                              image: FileImage(
                                                                  File(data[index]
                                                                          .image ??
                                                                      "")))
                                                          : DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                  data[index]
                                                                          .image ??
                                                                      ""))),
                                                );
                                        }));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Product Status : ',
                              style: TextStyle(
                                  color: AppColors.greyText,
                                  fontWeight: FontWeight.w600),
                            ),
                            CustomSwitch(
                              value: controller.enable,
                              onChanged: (val) {
                                controller.enable = val;
                              },
                              enableColor: AppColors.green,
                              disableColor: AppColors.pink,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'In Stock : ',
                              style: TextStyle(
                                  color: AppColors.greyText,
                                  fontWeight: FontWeight.w600),
                            ),
                            CustomSwitch(
                              value: true,
                              onChanged: (val) {
                                print(val);
                                if (val == false) {
                                  controller.productUnitController.text = "0";
                                } else {
                                  controller.productUnitController.text = "1";
                                }
                              },
                              enableColor: AppColors.green,
                              disableColor: AppColors.pink,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  spacer30,
                  buildTextFieldName(),
                  // spacer10,
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 4.0),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       AppStrings.tags,
                  //       style: TextStyle(
                  //           color: AppColors.black,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                  // spacer10,
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 60,
                  //   decoration: BoxDecoration(
                  //       // color: AppColors.green,
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(color: AppColors.lightGrey)),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: BlocBuilder<ProductBloc, ProductState>(
                  //           builder: (context, state) {
                  //             return ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const BouncingScrollPhysics(),
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount: controller.selectedTags.length,
                  //                 itemBuilder: (context, index) => TagCard(
                  //                     model:
                  //                         controller.selectedTags[index]));
                  //           },
                  //         ),
                  //       ),
                  //       IconButton(
                  //           onPressed: () {
                  //             GoRouter.of(context)
                  //                 .pushNamed(AppPages.tagSelect);
                  //           },
                  //           style: IconButton.styleFrom(
                  //               backgroundColor: AppColors.offWhite),
                  //           icon: const Icon(
                  //             Icons.add,
                  //             size: 30,
                  //           ))
                  //     ],
                  //   ),
                  // ),
                  spacer10,
                  // BlocBuilder<ProductBloc, ProductState>(
                  //   builder: (context, state) {
                  //     prettyPrint(
                  //         "list length ${controller.tagList.length}");
                  //     return controller.tagList.isEmpty
                  //         ? Container()
                  //         : SizedBox(
                  //             height: 30,
                  //             child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount: controller.tagList.length,
                  //                 itemBuilder: (context, index) =>
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         if (controller
                  //                             .tagList.isNotEmpty) {
                  //                           controller.removeTag(
                  //                               controller.tagList[index]);
                  //                           controller.add(
                  //                               DeleteTagsFilterEvent());
                  //                           // state.tags?.clear();
                  //                           // controller.addTags("val");
                  //                           // controller.add(
                  //                           //     AddTagsFilterEvent());
                  //                         }
                  //                       },
                  //                       child: Container(
                  //                         margin:
                  //                             const EdgeInsets.symmetric(
                  //                                 horizontal: 2),
                  //                         padding:
                  //                             const EdgeInsets.symmetric(
                  //                                 horizontal: 5),
                  //                         height: 30,
                  //                         decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(4),
                  //                             border: Border.all(
                  //                                 color: Colors.black)),
                  //                         child: Row(
                  //                           children: [
                  //                             Text(controller
                  //                                 .tagList[index]),
                  //                             const SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             const Icon(Icons.close)
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     )),
                  //           );
                  //   },
                  // ),
                  // spacer10,
                  Row(
                    children: [
                      Expanded(
                          child: CommonTextField(
                        controller: controller.productUnitController,
                        title: AppStrings.productUnit,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        required: true,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: buildTextFieldCategory()),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // Expanded(child: buildTextFieldSubCategory()),
                    ],
                  ),
                  // spacer10,
                  // buildTextPriceAndDiscountField(),
                  spacer10,
                  // Row(
                  //   children: [
                  //
                  //     // const SizedBox(
                  //     //   width: 10,
                  //     // ),
                  //     // Expanded(child: Builder(builder: (context) {
                  //     //   return GestureDetector(
                  //     //     onTap: () => buildTypeBottomSheet(context),
                  //     //     child: CommonTextField(
                  //     //       controller: controller.unitTypeController,
                  //     //       enable: false,
                  //     //       title: AppStrings.piece,
                  //     //       // suffix: Icon(Icons.keyboard_arrow_down_sharp),
                  //     //       widgetLabel: Row(
                  //     //         mainAxisAlignment:
                  //     //             MainAxisAlignment.spaceBetween,
                  //     //         children: const [
                  //     //           Text(
                  //     //             AppStrings.piece,
                  //     //             style: TextStyle(color: Colors.black),
                  //     //           ),
                  //     //           Icon(Icons.keyboard_arrow_down)
                  //     //         ],
                  //     //       ),
                  //     //     ),
                  //     //   );
                  //     // })),
                  //   ],
                  // ),
                  spacer10,
                  CommonTextField(
                    required: true,
                    title: AppStrings.productDetails,
                    controller: controller.productDetailsController,
                    lines: 4,
                  ),
                  spacer20,
                  GestureDetector(
                    onTap: () {
                      variantBloc.add(VariantsBulkAdd(controller.variants));
                      GoRouter.of(context).pushNamed(AppPages.addVariant);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAssets.add,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          AppStrings.addVariant,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.skyBlue,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // const Divider(
                  //   color: Colors.grey,
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: const Text(AppStrings.addCategory)),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // )
                  spacer30,
                  spacer30
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state is ProductFetching
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ))
                : const SizedBox();
          },
        )
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: getAppBar(
            context,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                      size: 25,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.id == null
                        ? AppStrings.addProduct
                        : AppStrings.editPrd,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Text(""))
              ],
            )),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            prettyPrint("CURRENT STATE $state");
            if (state is ProductFetchedDetail) {
              return _productForm();
            } else if (state is ProductFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _productForm();
            }
          },
        ),
        bottomNavigationBar:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return state is ProductFetching
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.id == null && imagePickerResult.value == "") {
                        commonErrorDialog(
                            context: context,
                            message: AppConstants.kSelectImageError);
                      } else if (controller
                          .productNameController.text.isEmpty) {
                        commonErrorDialog(
                            context: context,
                            message: AppConstants.kProductNameError,
                            action: () {});
                      } else if (controller.productNameController.text.length <
                          2) {
                        commonErrorDialog(
                            context: context,
                            message: AppConstants.kProductValidNameError);
                      } else if (controller.selectedCategory == null) {
                        commonErrorDialog(
                            context: context,
                            message: AppConstants.kSelectCategory);
                      } else if (controller.variants.isEmpty) {
                        commonErrorDialog(
                            context: context,
                            message: "Please add at-least one  variant");
                      } else {
                        if (controller.productUnitController.text.isEmpty) {
                          controller.productUnitController.text = "0";
                        }
                        controller.add(AddProductEvent(
                            context: context,
                            id: widget.id,
                            path: imagePickerResult.value));
                      }
                    },
                    child: const Text(
                      AppStrings.save,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class TagCard extends StatelessWidget {
  final TagEntity model;
  const TagCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.tagName,
              style: const TextStyle(color: AppColors.black),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.offWhite1,
                borderRadius: BorderRadius.circular(15)),
            child: GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.close,
                  color: AppColors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
