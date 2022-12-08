import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../widgets/custom_app_bar.dart';

class AddOrderProductScreen extends StatelessWidget {
  const AddOrderProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          spacer20,
          // productListTile(adding: true),
        ],
      ),
      appBar: getAppBar(
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              Expanded(
                  child: Image.asset(
                AppAssets.search,
                width: 23,
                height: 24,
              ))
            ],
          )),
    );
  }
}
