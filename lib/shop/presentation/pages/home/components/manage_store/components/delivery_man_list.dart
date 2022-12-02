import 'package:flutter/material.dart';
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
              const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              Text(
                AppStrings.deliveryMan,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox()
            ],
          )),
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
                          style: TextStyle(fontSize: 15),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                      Column(
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
                            style:
                                TextStyle(fontSize: 13, color: AppColors.black),
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
                              SizedBox(
                                width: 40,
                              ),
                              Image.asset(
                                AppAssets.edit,
                                width: 20,
                                height: 20,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  spacer10,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
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
