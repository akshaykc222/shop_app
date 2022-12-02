import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class ManageStoreScreen extends StatelessWidget {
  const ManageStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardItem(
        {required String image,
        required String title,
        required Function onTap}) {
      return GestureDetector(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: AppColors.cardLightGrey,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    image,
                    width: 24,
                    height: 21,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              spacer14,
              Text(
                title,
                style: const TextStyle(
                    color: AppColors.semiLightGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.manageStore,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            spacer37,
            Row(
              children: [
                Expanded(
                    child: cardItem(
                        image: AppAssets.storeTiming,
                        title: AppStrings.storeTiming,
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppPages.storeTiming);
                        })),
                const SizedBox(
                  width: 26,
                ),
                Expanded(
                    child: cardItem(
                        image: AppAssets.deliveryMan,
                        title: AppStrings.deliveryMan,
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppPages.deliveryman);
                        })),
              ],
            ),
            spacer26,
            Row(
              children: [
                Expanded(
                    child: cardItem(
                        image: AppAssets.myCustomer,
                        title: AppStrings.myCustomer,
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppPages.customerList);
                        })),
                const SizedBox(
                  width: 26,
                ),
                Expanded(
                    child: cardItem(
                        image: AppAssets.delivery,
                        title: AppStrings.delivery,
                        onTap: () {})),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
