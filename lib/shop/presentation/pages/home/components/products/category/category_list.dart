import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_form.dart';

import '../../../../../themes/app_assets.dart';
import '../../../../../themes/app_strings.dart';
import '../../../../../widgets/shining_button.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: 120,
            child: Image.asset(
              AppAssets.productImg,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppStrings.createCategoryDesc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppStrings.createCategoryDescSub,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Spacer(),
          ShiningButton(
            title: AppStrings.addNewCategory,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CategoryAddForm())),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
