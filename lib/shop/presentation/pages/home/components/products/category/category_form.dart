import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

import '../../../../../themes/app_strings.dart';
import '../../../../../widgets/custom_app_bar.dart';

class CategoryAddForm extends StatelessWidget {
  final CategoryEntity? entity;
  const CategoryAddForm({Key? key, this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CategoryBloc.get(context);
    buildImageWidget() {
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
            child: entity == null
                ? const Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: AppColors.lightGrey,
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: entity?.image ?? "",
                    fit: BoxFit.contain,
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            AppStrings.addImage,
            style: TextStyle(
                color: AppColors.skyBlue, fontWeight: FontWeight.w600),
          )
        ],
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
                  AppStrings.editOrder,
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
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)))),
            child: const Text(
              AppStrings.addCategory,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            )),
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
