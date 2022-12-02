import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget customerCard() {
      return Card(
        color: AppColors.cardLightGrey,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              spacer10,
              Row(
                children: const [
                  Text(
                    "Suresh kanan",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.black),
                  ),
                ],
              ),
              spacer9,
              Row(
                children: [
                  Text(
                    "malapuram",
                    style: TextStyle(fontSize: 13, color: AppColors.black),
                  )
                ],
              ),
              spacer20,
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      "Total Orders",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "Total Sales",
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              ),
              spacer10,
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      "15 AED",
                      style: TextStyle(color: AppColors.skyBlue, fontSize: 19),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "108 AED",
                      style: TextStyle(color: AppColors.skyBlue, fontSize: 19),
                    ),
                  )
                ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              Text(
                AppStrings.customerList,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox()
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            spacer20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  AppStrings.lyfTym,
                  style: TextStyle(color: AppColors.greyText),
                ),
                Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
            customerCard()
          ],
        ),
      ),
    );
  }
}
