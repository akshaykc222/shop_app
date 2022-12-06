import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../themes/app_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget sideCard(
        {required String title, required String image, Color? color}) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightBorderColor.withOpacity(0.24)))),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 25,
              height: 29,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? const Color(0XFF484848),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      AppStrings.profile,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              const Expanded(child: SizedBox())
            ],
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spacer37,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppAssets.whatsApp))),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.skyBlue),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(
                              AppAssets.edit,
                              width: 10,
                              height: 10,
                              color: AppColors.white,
                              fit: BoxFit.cover,
                            ),
                          ))),
                ),
              ],
            ),
            spacer10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Name Of The Company",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.skyBlue),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  AppAssets.edit,
                  width: 13,
                  height: 13,
                  color: AppColors.skyBlue,
                  fit: BoxFit.fill,
                )
              ],
            ),
            spacer5,
            const Text(
              "Name@gmail.com",
              style: TextStyle(color: AppColors.greyText, fontSize: 15),
            ),
            spacer5,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "+9715 45 678965 | Dubai, United Arab Emirates",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: 15,
                ),
              ),
            ),
            spacer30,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.cardLightGrey,
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0.0, 1.0),
                      blurRadius: 2.0,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.orderProfile,
                        width: 33,
                        height: 40,
                        color: AppColors.skyBlue,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "20",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.skyBlue),
                          ),
                          Text(
                            AppStrings.orders,
                            style: TextStyle(color: AppColors.black),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.revenue,
                        width: 33,
                        height: 40,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "324 AED",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.skyBlue),
                          ),
                          Text(
                            AppStrings.revenue,
                            style: TextStyle(color: AppColors.black),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // spacer37,
            sideCard(
                title: AppStrings.changePassword,
                image: AppAssets.changePassword),
            sideCard(title: AppStrings.contactUs, image: AppAssets.contactUs),
            sideCard(title: AppStrings.logOut, image: AppAssets.logout),
            sideCard(title: AppStrings.deleteAccount, image: AppAssets.delete),
          ],
        ),
      ),
    );
  }
}
