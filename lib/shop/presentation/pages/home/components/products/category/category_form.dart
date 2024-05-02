import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';

import '../../../../../themes/app_strings.dart';
import '../../../../../utils/select_image_and_crop.dart';
import '../../../../../widgets/custom_app_bar.dart';
import 'category_list.dart';

class CategoryAddForm extends StatefulWidget {
  final CategoryEntity? entity;
  const CategoryAddForm({Key? key, this.entity}) : super(key: key);

  @override
  State<CategoryAddForm> createState() => _CategoryAddFormState();
}

class _CategoryAddFormState extends State<CategoryAddForm> {
  late CategoryBloc controller;

  ValueNotifier<String> imagePickerResult = ValueNotifier("");
  buildImageWidget() {
    return GestureDetector(
      onTap: () async {
        var result = await selectImageAndCropImage(
            context: context, title: AppStrings.selectImage);
        if (result != null) {
          imagePickerResult.value = result.path ?? "";
          // controller.image = result.path ?? "";
          imagePickerResult.notifyListeners();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 38,
          ),
          ValueListenableBuilder(
              valueListenable: imagePickerResult,
              builder: (context, val, child) {
                return Container(
                  width: 138,
                  height: 138,
                  decoration: BoxDecoration(
                      // color: AppColors.lightGrey,
                      border: Border.all(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(19)),
                  child: val != ""
                      ? Image.file(File(val))
                      : widget.entity == null
                          ? const Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                                color: AppColors.lightGrey,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(19),
                              child: CachedNetworkImage(
                                imageUrl: widget.entity?.image ?? "",
                                fit: BoxFit.contain,
                              ),
                            ),
                );
              }),
          const SizedBox(
            height: 12,
          ),
          const Text(
            AppStrings.addImage,
            style: TextStyle(
                color: AppColors.skyBlue, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  buildTextField() {
    return CommonTextField(
      title: AppStrings.categoryName,
      controller: controller.categoryNameController,
    );
  }

  var scrollController = ScrollController();

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
                      spacer20,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.searchController,
                              decoration: const InputDecoration(
                                  hintText: "Search ... "),
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                controller.add(CategorySearchEvent(
                                    controller.searchController.text));
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                              ))
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.categoryList.length + 1,
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => controller
                                        .categoryList.length ==
                                    index
                                ? controller.currentPage < controller.totalPage
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const ShimmerCategoryLoad())
                                    : Container()
                                : CategoryListTile(
                                    entity: controller.categoryList[index],
                                    edit: () {},
                                    selectable: true,
                                    select: () {
                                      controller.changeSelectedCategory(
                                          controller.categoryList[index]);
                                      FocusScope.of(context).unfocus();
                                      Navigator.pop(context);
                                    },
                                    delete: () {},
                                  )),
                      ),
                    ],
                  ),
                ));
      },
      child: CommonTextField(
        enable: false,
        controller: controller.categoryController,
        title: AppStrings.parentCat,
        required: true,
      ),
    );
  }

  @override
  void initState() {
    controller = CategoryBloc.get(context);
    controller.changeSelectedChoice(AppStrings.yes);
    controller.changeSelectedCategory(null);
    if (widget.entity != null) {
      controller.updateForEditing(widget.entity!);
    }
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.getPaginatedResponse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  widget.entity == null
                      ? AppStrings.addCategory
                      : AppStrings.editCategory,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Text(""))
            ],
          )),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ElevatedButton(
                onPressed: state is CategoryLoadingState
                    ? null
                    : () {
                        if (widget.entity == null) {
                          controller.add(AddCategoryEvent(
                              name: controller.categoryNameController.text,
                              filePath: imagePickerResult.value,
                              parentId: null,
                              context: context));
                        } else {
                          controller.add(UpdateCategoryEvent(
                              context: context,
                              request: CategoryModel(
                                  name: controller.categoryNameController.text,
                                  image: imagePickerResult.value,
                                  id: widget.entity!.id)));
                        }
                      },
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)))),
                child: state is CategoryLoadingState
                    ? const CircularProgressIndicator()
                    : Text(
                        widget.entity == null
                            ? AppStrings.addCategory
                            : AppStrings.editCategory,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageWidget(),
              const SizedBox(
                height: 20,
              ),
              buildTextField(),
              // spacer20,
              // const MandatoryText(
              //   title: AppStrings.parentCatQuest,
              // ),
              // BlocBuilder<CategoryBloc, CategoryState>(
              //   builder: (context, state) {
              //     return Column(
              //       children: [
              //         Row(
              //           children: [
              //             const Text(AppStrings.yes),
              //             Radio(
              //                 value: AppStrings.yes,
              //                 groupValue: controller.selectedChoice,
              //                 onChanged: (val) {
              //                   if (widget.entity == null) {
              //                     controller.changeSelectedChoice(
              //                         val ?? AppStrings.yes);
              //                   }
              //                 }),
              //             const Text(AppStrings.no),
              //             Radio(
              //                 value: AppStrings.no,
              //                 groupValue: controller.selectedChoice,
              //                 onChanged: (val) {
              //                   if (widget.entity == null) {
              //                     controller.changeSelectedChoice(
              //                         val ?? AppStrings.yes);
              //                   }
              //                 }),
              //           ],
              //         ),
              //         controller.selectedChoice == AppStrings.no
              //             ? buildTextFieldCategory()
              //             : const SizedBox()
              //       ],
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
