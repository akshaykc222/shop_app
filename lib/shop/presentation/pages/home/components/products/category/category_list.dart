import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';

import '../../../../../../domain/entities/category_entity.dart';
import '../../../../../themes/app_assets.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_strings.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../widgets/custom_switch.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CategoryBloc.get(context);
    controller.add(GetCategoryEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppPages.addCategory);
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadedState) {
            return ListView.builder(
                itemCount: state.data.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => CategoryListTile(
                      entity: state.data[index],
                    ));
          } else if (state is CategoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CategoryListTile extends StatelessWidget {
  final CategoryEntity entity;
  final bool? reOrder;
  const CategoryListTile({super.key, required this.entity, this.reOrder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.offWhite1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 20, top: 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Container(
                                width: 82,
                                height: 82,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: entity.image,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  spacer22,
                                  Text(
                                    entity.name,
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  spacer10,
                                  const Text(
                                    "1 product listed",
                                    style: TextStyle(
                                        color: AppColors.offWhiteTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  spacer9,
                                  // const Text(
                                  //   "Active",
                                  //   style: TextStyle(
                                  //       color: AppColors.green,
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.w600),
                                  // )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  spacer37,

                                  // const Spacer(),
                                  CustomSwitch(
                                    value: entity.status,
                                    enableColor: AppColors.green,
                                    disableColor: AppColors.brown,
                                    onChanged: (value) {},
                                    height: 27,
                                    width: 51,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      spacer20,
                    ],
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: PopupMenuButton(
                      icon: Image.asset(
                        AppAssets.menu,
                        width: 20,
                        height: 20,
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.edit,
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text(
                                    AppStrings.edit,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppColors.black),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.delete,
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text(
                                    AppStrings.deleteCategory,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppColors.pink),
                                  )
                                ],
                              ),
                            ),
                          ]),
                )
              ],
            ),
          ),
          reOrder == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.ordering,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
