import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/domain/entities/category_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/products/category/category_list.dart';

import '../../../../../widgets/custom_app_bar.dart';

class SubCategoryScreen extends StatefulWidget {
  final CategoryEntity categoryEntity;

  const SubCategoryScreen({Key? key, required this.categoryEntity})
      : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late CategoryBloc controller;
  var scrollController = ScrollController();
  @override
  void initState() {
    controller = CategoryBloc.get(context);
    controller.add(GetSubCategoryEvent(
        context: context,
        request: CategoryRequestModel(
            name: widget.categoryEntity.name,
            image: widget.categoryEntity.image,
            parentId: int.parse(widget.categoryEntity.id))));
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.add(GetSubCategoryPaginatedEvent(
          context: context,
          request: CategoryRequestModel(
              name: widget.categoryEntity.name,
              image: widget.categoryEntity.image,
              parentId: int.tryParse(widget.categoryEntity.id))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              Expanded(
                  child: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              )),
              Expanded(
                  flex: 3,
                  child: Text(
                    widget.categoryEntity.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              const Expanded(child: SizedBox())
            ],
          )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // controller.clearTextFields();
      //     // controller.changeSelectedChoice(AppStrings.yes);
      //     GoRouter.of(context).pushNamed(AppPages.editCategory,
      //         params: {'model': jsonEncode(widget.categoryEntity.toJson())});
      //   },
      //   child: const Center(
      //     child: Icon(Icons.add),
      //   ),
      // ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => const ShimmerCategoryLoad()),
            );
          }
          //
          // }
          return controller.subCategoryList.isEmpty
              ? const Center(
                  child: Text("No Subcategories"),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: controller.subCategoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CategoryListTile(
                        entity: controller.subCategoryList[index],
                        edit: () {},
                        delete: () {
                          controller.add(DeleteCategoryEvent(
                              context: context,
                              id: int.parse(
                                  controller.subCategoryList[index].id)));
                        },
                      ));
        },
      ),
    );
  }
}
