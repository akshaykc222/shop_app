import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class DeliveryManList extends StatelessWidget {
  const DeliveryManList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    AppStrings.deliveryMan,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox())
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppPages.deliverymanAdd);
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            spacer26,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const Text(
                //   AppStrings.overview,
                //   style: TextStyle(
                //       color: AppColors.black,
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600),
                // ),
                PopupMenuButton(
                    child: Row(
                      children: const [
                        Text(
                          AppStrings.lyfTym,
                          style: TextStyle(
                              fontSize: 15, color: AppColors.greyText),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                    itemBuilder: (context) =>
                        [PopupMenuItem(child: Container())]),
              ],
            ),
            spacer24,
            Card(
              color: AppColors.cardLightGrey,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 5, left: 20, right: 20),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: CachedNetworkImageProvider(
                                      'https://mapleridge.com/sites/default/files/wp-content/uploads/2014/10/Delivery-Man-iStock_000009564355Medium.jpg'))),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "suresh kanann",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            spacer10,
                            const Text(
                              "mail@gmail.com",
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.black),
                            ),
                            spacer5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "+9715 23 678 989",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.black),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Image.asset(
                                    AppAssets.edit,
                                    width: 20,
                                    height: 20,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "${AppStrings.totalOrdersSaved} :",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black),
                        ),
                        Text(
                          " 37",
                          style: TextStyle(
                              color: AppColors.skyBlue,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
