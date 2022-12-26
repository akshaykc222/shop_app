import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

import '../../../../../themes/app_strings.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../widgets/custom_app_bar.dart';

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
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: SizedBox(
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(AppStrings.uploadProductImage,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.close,
                                  size: 25,
                                ))
                          ],
                        ),
                        spacer20,
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();

                                      final XFile? image =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);
                                      imagePickerResult.value =
                                          image?.path ?? "";
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 50,
                                        ),
                                        spacer5,
                                        const Text(AppStrings.camara)
                                      ],
                                    ))),
                            Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();

                                      final XFile? image =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);
                                      imagePickerResult.value =
                                          image?.path ?? "";
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.image_outlined,
                                          size: 50,
                                        ),
                                        spacer5,
                                        const Text(AppStrings.gallery)
                                      ],
                                    ))),
                          ],
                        ),
                        // spacer20,
                      ],
                    ),
                  ),
                ));
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.categoryName,
            style: TextStyle(
                color: AppColors.offWhiteTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ),
        TextFormField(
          controller: controller.categoryNameController,
          decoration:
              const InputDecoration(label: Text(AppStrings.categoryName)),
        ),
      ],
    );
  }

  @override
  void initState() {
    controller = CategoryBloc.get(context);
    if (widget.entity != null) {
      controller.updateForEditing(widget.entity!);
    }
    super.initState();
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
                              context: context));
                        } else {
                          controller.add(UpdateCategoryEvent(
                              context: context,
                              request: CategoryRequestModel(
                                  name: controller.categoryNameController.text,
                                  image: imagePickerResult.value,
                                  id: int.tryParse(widget.entity!.id))));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildImageWidget(),
            const SizedBox(
              height: 20,
            ),
            buildTextField(),
          ],
        ),
      ),
    );
  }
}
