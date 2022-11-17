import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/pages/home/components/orders/components/order_detail.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/ripple_round.dart';

import '../../../../themes/app_assets.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_strings.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              // final controller = OrderBloc.get(context);
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0.0, 1.0), //(x,y)
                          blurRadius: 4.0,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            AppStrings.orders,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                AppAssets.search,
                                width: 24.05,
                                height: 23.96,
                              )),
                          const SizedBox(
                            width: 28.75,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                spacer26,
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.statusList.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  controller.changeSelectedFilter(
                                      controller.statusList[index]);
                                  controller.add(ChangeTagEvent());
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: controller.selectedFilter ==
                                              controller.statusList[index]
                                          ? AppColors.primaryColor
                                          : null,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1.2)),
                                  child: Text(
                                    controller.statusList[index],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: controller.selectedFilter ==
                                                controller.statusList[index]
                                            ? AppColors.white
                                            : AppColors.primaryColor),
                                  ),
                                ),
                              )),
                    );
                  },
                ),
                spacer24,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.allOrders,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => controller.add(ChangeToggleEvent()),
                        child: Row(
                          children: const [
                            Text(
                              AppStrings.lyfTym,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                spacer24,
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return controller.orderList.isEmpty
                        ? Column(
                            children: [
                              const Spacer(),
                              SizedBox(
                                height: 120,
                                child: Image.asset(
                                  AppAssets.productImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppStrings.youDonnHaveOrders,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  AppStrings.shareYourStoreLink,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Share.share('hi',
                                          subject: 'Look what I made!');
                                    },
                                    child: const Text(
                                      AppStrings.shareYourStore,
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                              spacer30,
                              // ShiningButton(
                              //   title: AppStrings.addNewProduct,
                              //   onTap: () => {
                              //     // Navigator.of(context).push(
                              //     //     MaterialPageRoute(builder: (context) => const ProductForm()))
                              //   },
                              // ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : Container(
                            child: Column(
                              children: [OrderSmallCard()],
                            ),
                          );
                  },
                ),
              ],
            ),
            Positioned(
                right: 5,
                top: 20,
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return controller.showLyfTym
                        ? Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "Today",
                                      "Yesterday",
                                      "This Week",
                                      "Last Week",
                                      "This Month",
                                      "Last Month",
                                      "Lifetime",
                                      "Custom range"
                                    ]
                                        .map((e) => Container(
                                              width: 140,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.add(
                                                        ChangeToggleEvent());
                                                  },
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  },
                ))
          ],
        ));
  }
}

class OrderSmallCard extends StatelessWidget {
  const OrderSmallCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.offWhite1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Order # 5670125",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                Text(
                  "Today , 12:50 pm",
                  style: TextStyle(
                      color: AppColors.offBlack,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ],
            ),
          ),
          spacer22,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "1 ITEM",
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  spacer10,
                  const Text(
                    "₹15",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "COD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent),
                  )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          spacer5,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: RippleButton(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Pending",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OrderDetails()))
                  },
                  child: Container(
                    width: 80,
                    height: 35,
                    // decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.details,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.6)),
                        ),
                        Image.asset(
                          AppAssets.rightArrow,
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
