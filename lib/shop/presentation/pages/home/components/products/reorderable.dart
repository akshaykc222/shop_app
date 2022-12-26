import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';

import '../../../../themes/app_strings.dart';
import '../../../../widgets/custom_app_bar.dart';

class ReOrderableListCategoryScreen extends StatelessWidget {
  const ReOrderableListCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.catalogue,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: const Icon(
                  Icons.done,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadedState) {
            return ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {},
                children: state.data
                    .map((e) => Container(
                          key: ValueKey(e.id),
                          child: CategoryListTile(
                            entity: e,
                            reOrder: true,
                            edit: () {},
                            delete: () {},
                          ),
                        ))
                    .toList());
          }
          return Container();
        },
      ),
    );
  }
}
