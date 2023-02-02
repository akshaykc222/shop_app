import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class TagListScreen extends StatelessWidget {
  const TagListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ProductBloc.get(context);
    controller.add(GetTagsEvent(context));
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ))),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Select Tags",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              Expanded(
                  child: IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: const Icon(Icons.done),
              ))
            ],
          )),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductFetching) {
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 16 / 3),
                  itemCount: controller.tagFetchList.length,
                  itemBuilder: (context, index) => SizedBox(
                        width: 150,
                        height: 30,
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: const SizedBox(
                              width: 150,
                            )),
                      ));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8, // space between items
                children: controller.tagFetchList
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.changeSelectedTags(e);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: controller.selectedTags.contains(e)
                                        ? AppColors.green
                                        : AppColors.lightGrey,
                                  )),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  e.tagName,
                                  style: TextStyle(
                                      color: controller.selectedTags.contains(e)
                                          ? AppColors.green
                                          : AppColors.lightGrey),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
