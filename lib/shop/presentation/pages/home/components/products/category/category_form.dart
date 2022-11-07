import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

import '../../../../../themes/app_strings.dart';

class CategoryAddForm extends StatelessWidget {
  const CategoryAddForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildImageWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                // color: AppColors.lightGrey,
                border: Border.all(color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: AppColors.lightGrey,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            AppStrings.addCategoryImage,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
    }

    buildTextField() {
      return TextFormField(
        decoration: const InputDecoration(label: Text(AppStrings.categoryName)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.addCategory),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageWidget(),
            const SizedBox(
              height: 20,
            ),
            buildTextField(),
            const Spacer(),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(AppStrings.addCategory)),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
