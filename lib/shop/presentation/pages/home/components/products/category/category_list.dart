import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/category_bloc/category_bloc.dart';

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
    Widget categoryListTile({required CategoryEntity entity}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.5),
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
                  spacer18,
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 20),
                    child: Row(
                      children: [
                        Container(
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
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            spacer18,
                            PopupMenuButton(
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
                        )
                      ],
                    ),
                  ),
                  spacer30,
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                itemBuilder: (context, index) => categoryListTile(
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
