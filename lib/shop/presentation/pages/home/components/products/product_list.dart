import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';

import '../../../../themes/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../widgets/custom_switch.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ProductBloc.get(context);
    controller.add(ProductFetchEvent(
        () {}, (p0) => () {}, () => handleUnAuthorizedError(context)));
    emptyList() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 143,
            height: 130,
            child: Image.asset(
              AppAssets.productImg,
              fit: BoxFit.fill,
            ),
          ),
          spacer18,
          const Text(
            AppStrings.addProductDesc,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
          spacer18,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              AppStrings.addProductDescSub,
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
            ),
          ),
          // ShiningButton(
          //   title: AppStrings.addNewProduct,
          //   onTap: () => {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => const ProductForm()))
          //   },
          // ),
          // const SizedBox(
          //   height: 10,
          // )
        ],
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(AppPages.addProduct);
          },
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductFetchError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) =>
                      productListTile(entity: controller.productList[index]));
            }
          },
        ));
  }
}

Widget productListTile(
    {bool? changePosition, bool? adding, required ProductModel entity}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
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
                          // color: Colors.grey,
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
                          Text(
                            "${(entity.stock ?? "")}${(entity.unit?.unit ?? "")}",
                            style: TextStyle(
                                color: AppColors.offWhiteTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          spacer9,
                          const Text(
                            "In stock",
                            style: TextStyle(
                                color: AppColors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    adding == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              spacer20,
                              spacer30,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 2),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.skyBlue),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text(
                                  AppStrings.add,
                                  style: TextStyle(
                                    color: AppColors.skyBlue,
                                  ),
                                )),
                              ),
                            ],
                          )
                        : Column(
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
                                                AppAssets.moveTop,
                                                width: 15,
                                                height: 15,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Text(
                                                AppStrings.moveTop,
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
                                value: false,
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
              // spacer10,
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Divider(),
              // ),
              // spacer10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       AppAssets.sharedFilled,
              //       width: 20,
              //       height: 20,
              //     ),
              //     SizedBox(
              //       width: 8,
              //     ),
              //     const Text(
              //       AppStrings.share,
              //       style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           color: AppColors.skyBlue),
              //     ),
              //   ],
              // ),
              spacer18,
            ],
          ),
        ),
      ],
    ),
  );
}
