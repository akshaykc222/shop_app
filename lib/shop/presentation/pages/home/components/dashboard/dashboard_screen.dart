import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/custom_switch.dart';

import '../../../../../data/test_data.dart';
import '../../../../themes/app_assets.dart';
import '../../../../themes/app_strings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget overViewCard(
        {required String title,
        required String image,
        required String content}) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: AppColors.cardLightGrey,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  image,
                  width: 15,
                  height: 15,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.37)),
                )
              ],
            ),
            spacer10,
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                content,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      );
    }

    Widget deliveryBoyCard(
        {required String title,
        required String image,
        required String orders}) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        // height: 150,
        child: Card(
          color: AppColors.cardLightGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          child: Column(
            children: [
              spacer10,
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    image: DecorationImage(
                        image: AssetImage(AppAssets.productImg))),
              ),
              spacer10,
              Text(
                title,
                style: const TextStyle(fontSize: 13, color: AppColors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.orders,
                      color: Colors.white,
                      width: 10,
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Orders :',
                          style: const TextStyle(fontSize: 10),
                          children: <TextSpan>[
                            TextSpan(
                                text: orders,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              spacer14
            ],
          ),
        ),
      );
    }

    Widget topSellingItems({
      required String title,
      required String image,
      required String sold,
    }) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 120,
        child: Card(
          color: AppColors.cardLightGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
            child: Row(
              children: [
                Container(
                    width: 82,
                    height: 82,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(image)),
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.black),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.orders,
                              color: Colors.white,
                              width: 10,
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Orders :',
                                  style: const TextStyle(fontSize: 10),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: sold,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: getAppBar(
          context,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    AppAssets.shop,
                    width: 24,
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      "E -Store",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 27.0),
                    child: Row(
                      children: [
                        Text(
                          "offline",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.black.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        CustomSwitch(
                          value: false,
                          onChanged: (val) {},
                          disableColor: AppColors.red,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              spacer10
            ],
          ),
          height: 80),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              spacer26,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.overview,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
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
              Row(
                children: [
                  Expanded(
                    child: overViewCard(
                        title: AppStrings.confirmed,
                        image: AppAssets.confirmed,
                        content: "0"),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: overViewCard(
                        title: AppStrings.processing,
                        image: AppAssets.processing,
                        content: "12 AED"),
                  ),
                ],
              ),
              spacer18,
              Row(
                children: [
                  Expanded(
                    child: overViewCard(
                        title: "Pending",
                        image: AppAssets.readyToDeliver,
                        content: "0"),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: overViewCard(
                        title: AppStrings.processing,
                        image: AppAssets.onTheWay,
                        content: "12 AED"),
                  ),
                ],
              ),
              spacer24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    AppStrings.topDeliveryMan,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              spacer20,
              Row(
                children: [
                  deliveryBoyCard(
                      title: "akshay",
                      image: AppAssets.changePassword,
                      orders: "5")
                ],
              ),
              spacer20,
              Row(
                children: const [
                  Text(
                    AppStrings.overview,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              spacer20,
              Row(
                children: [
                  topSellingItems(
                      title: "tester",
                      image: AppAssets.changePassword,
                      sold: "5"),
                ],
              ),
              spacer24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    AppStrings.topDeliveryMan,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              spacer20,
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.all(8),
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.cardLightGrey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              children: const [
                                Text("This Week"),
                                Icon(Icons.keyboard_arrow_down_outlined)
                              ],
                            ))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 350,
                      height: 300,
                      child: Chart(
                        data: basicData,
                        variables: {
                          'genre': Variable(
                            accessor: (Map map) => map['genre'] as String,
                          ),
                          'sold': Variable(
                            accessor: (Map map) => map['sold'] as num,
                          ),
                        },
                        elements: [
                          IntervalElement(
                            label: LabelAttr(
                                encoder: (tuple) =>
                                    Label(tuple['sold'].toString())),
                            elevation: ElevationAttr(value: 0, updaters: {
                              'tap': {true: (_) => 5}
                            }),
                            color: ColorAttr(
                                value: Defaults.primaryColor,
                                updaters: {
                                  'tap': {
                                    false: (color) => color.withAlpha(100)
                                  }
                                }),
                            selected: {
                              'tap': {0}
                            },
                          )
                        ],
                        axes: [
                          Defaults.horizontalAxis,
                          Defaults.verticalAxis,
                        ],
                        selections: {'tap': PointSelection(dim: Dim.x)},
                        tooltip: TooltipGuide(),
                        crosshair: CrosshairGuide(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
