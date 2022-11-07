import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/product_form.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/widgets/shining_button.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

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
            AppStrings.addProductDesc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppStrings.addProductDescSub,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Spacer(),
          ShiningButton(
            title: AppStrings.addNewProduct,
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProductForm()))
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
