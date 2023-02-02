import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import 'package:shop_app/shop/presentation/manager/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/custom_switch.dart';

import '../../../../../data/test_data.dart';
import '../../../../themes/app_assets.dart';
import '../../../../themes/app_strings.dart';
import '../../../../widgets/no_internet_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Widget overViewCard(
      {required String title, required String image, required String content}) {
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
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

  Widget deliveryBoyCard(
      {required String title, required String image, required String orders}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      // height: 150,
      child: Card(
        color: AppColors.cardLightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
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
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          "https://goodmenproject.com/wp-content/uploads/2013/07/Robert2.jpg"))),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
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
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.shopify.com%2Fs%2Ffiles%2F1%2F0011%2F2341%2F8172%2Fproducts%2FTM838-Tasti-Lee-single_1024x1024.jpg%3Fv%3D1523418370&f=1&nofb=1&ipt=20741e525ea5dc66296e7caf5ab6d4da82d312b0f7edda3311dbc6af3374f5ad&ipo=images",
                    fit: BoxFit.fill,
                  )),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      title,
                      style:
                          const TextStyle(fontSize: 13, color: AppColors.black),
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

  changeStoreStatus() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) => Wrap(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.goOnlineAfter,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          dashboardBloc.add(ChangeStoreStatus(context,
                              status: false, opensIn: null));
                          storeStatus.value = false;
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  "1 hour",
                  "2 Hour",
                  "4 Hour",
                  "Tomorrow ,at same time",
                ]
                    .map((e) => GestureDetector(
                          onTap: () {
                            switch (e) {
                              case "1 hour":
                                dashboardBloc.add(ChangeStoreStatus(context,
                                    status: false, opensIn: "01:00:00"));
                                break;
                              case "2 hour":
                                dashboardBloc.add(ChangeStoreStatus(context,
                                    status: false, opensIn: "02:00:00"));
                                break;
                              case "4 hour":
                                dashboardBloc.add(ChangeStoreStatus(context,
                                    status: false, opensIn: "04:00:00"));
                                break;
                              default:
                                dashboardBloc.add(ChangeStoreStatus(context,
                                    status: false, opensIn: "24:00:00"));
                                break;
                            }
                            storeStatus.value = false;

                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                Radio(
                                    value: false,
                                    groupValue: 1,
                                    onChanged: (val) {}),
                                Text(
                                  e,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)))),
                    onPressed: () {},
                    child: const Text(
                      AppStrings.save,
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ]));
  }

  late DashboardBloc dashboardBloc;
  final storeStatus = ValueNotifier(true);
  @override
  void initState() {
    dashboardBloc = DashboardBloc.get(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Column(
            children: [
              ValueListenableBuilder(
                builder: (context, data, child) {
                  return Row(
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
                              storeStatus.value ? "Online" : "Offline",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            CustomSwitch(
                              value: storeStatus.value,
                              onChanged: (val) {
                                if (val == true) {
                                  dashboardBloc.add(ChangeStoreStatus(context,
                                      status: true, opensIn: null));
                                  storeStatus.value = true;
                                } else {
                                  changeStoreStatus();
                                }
                              },
                              enableColor: AppColors.green,
                              disableColor: AppColors.red,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                valueListenable: storeStatus,
              ),
              spacer10
            ],
          ),
          height: 80),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Column(
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
                                    title: "Pending",
                                    image: AppAssets.confirmed,
                                    content: dashboardBloc.model?.data
                                            .statusCount.processingOrders
                                            .toString() ??
                                        "0"),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: overViewCard(
                                    title: "Accepted",
                                    image: AppAssets.processing,
                                    content: dashboardBloc.model?.data
                                            .statusCount.confirmedOrders
                                            .toString() ??
                                        "0"),
                              ),
                            ],
                          ),
                          spacer18,
                          Row(
                            children: [
                              Expanded(
                                child: overViewCard(
                                    title: "Shipped",
                                    image: AppAssets.readyToDeliver,
                                    content: dashboardBloc.model?.data
                                            .statusCount.onthewayOrders
                                            .toString() ??
                                        "0"),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: overViewCard(
                                    title: "Cancelled",
                                    image: AppAssets.onTheWay,
                                    content: dashboardBloc.model?.data
                                            .statusCount.confirmedOrders
                                            .toString() ??
                                        "0"),
                              ),
                            ],
                          ),
                          (dashboardBloc.model?.data.topDeliveryMan.length ??
                                      0) ==
                                  0
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    spacer24,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: dashboardBloc.model?.data
                                                  .topDeliveryMan.length ??
                                              0,
                                          itemBuilder: (context, index) =>
                                              deliveryBoyCard(
                                                  title: dashboardBloc
                                                      .model!
                                                      .data
                                                      .topDeliveryMan[index]
                                                      .name,
                                                  image:
                                                      AppAssets.changePassword,
                                                  orders: dashboardBloc
                                                      .model!
                                                      .data
                                                      .topDeliveryMan[index]
                                                      .ordersCount
                                                      .toString())),
                                    ),
                                    spacer20,
                                  ],
                                ),
                          (dashboardBloc.model?.data.topSellingItems.length ??
                                      0) ==
                                  0
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          "Top selling items",
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    spacer20,
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      child: ListView.builder(
                                        itemCount: dashboardBloc.model?.data
                                                .topSellingItems.length ??
                                            0,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            topSellingItems(
                                                title: dashboardBloc
                                                    .model!
                                                    .data
                                                    .topSellingItems[index]
                                                    .name,
                                                image: AppAssets.changePassword,
                                                sold: dashboardBloc
                                                    .model!
                                                    .data
                                                    .topSellingItems[index]
                                                    .orderCount
                                                    .toString()),
                                      ),
                                    ),
                                    spacer24,
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppStrings.revenueGraph,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin: const EdgeInsets.all(8),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: AppColors.cardLightGrey,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(
                                          children: const [
                                            Text("This Week"),
                                            Icon(Icons
                                                .keyboard_arrow_down_outlined)
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
                                        accessor: (Map map) =>
                                            map['genre'] as String,
                                      ),
                                      'sold': Variable(
                                        accessor: (Map map) =>
                                            map['sold'] as num,
                                      ),
                                    },
                                    elements: [
                                      IntervalElement(
                                        label: LabelAttr(
                                            encoder: (tuple) => Label(
                                                tuple['sold'].toString())),
                                        elevation:
                                            ElevationAttr(value: 0, updaters: {
                                          'tap': {true: (_) => 5}
                                        }),
                                        color: ColorAttr(
                                            value: Defaults.primaryColor,
                                            updaters: {
                                              'tap': {
                                                false: (color) =>
                                                    color.withAlpha(100)
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
                                    selections: {
                                      'tap': PointSelection(dim: Dim.x)
                                    },
                                    tooltip: TooltipGuide(),
                                    crosshair: CrosshairGuide(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Positioned(
              bottom: 0, left: 0, right: 0, child: NoInternetWidget())
        ],
      ),
    );
  }
}
// class DashBoardShimmer extends StatelessWidget {
//   const DashBoardShimmer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             spacer26,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   AppStrings.overview,
//                   style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 PopupMenuButton(
//                     child: Row(
//                       children: const [
//                         Text(
//                           AppStrings.lyfTym,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Icon(Icons.keyboard_arrow_down_rounded)
//                       ],
//                     ),
//                     itemBuilder: (context) =>
//                     [PopupMenuItem(child: Container())]),
//               ],
//             ),
//             spacer24,
//             Row(
//               children: [
//                 Expanded(
//                   child: overViewCard(
//                       title: "Pending",
//                       image: AppAssets.confirmed,
//                       content: "0"),
//                 ),
//                 const SizedBox(
//                   width: 14,
//                 ),
//                 Expanded(
//                   child: overViewCard(
//                       title: "Accepted",
//                       image: AppAssets.processing,
//                       content: "1"),
//                 ),
//               ],
//             ),
//             spacer18,
//             Row(
//               children: [
//                 Expanded(
//                   child: overViewCard(
//                       title: "Shipped",
//                       image: AppAssets.readyToDeliver,
//                       content: "0"),
//                 ),
//                 const SizedBox(
//                   width: 14,
//                 ),
//                 Expanded(
//                   child: overViewCard(
//                       title: "Cancelled",
//                       image: AppAssets.onTheWay,
//                       content: "12 "),
//                 ),
//               ],
//             ),
//             spacer24,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   AppStrings.topDeliveryMan,
//                   style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             spacer20,
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: 5,
//                   itemBuilder: (context, index) => deliveryBoyCard(
//                       title: "akshay",
//                       image: AppAssets.changePassword,
//                       orders: "5")),
//             ),
//             spacer20,
//             Row(
//               children: const [
//                 Text(
//                   "Top selling items",
//                   style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             spacer20,
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               child: ListView.builder(
//                 itemCount: 4,
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) => topSellingItems(
//                     title: "tester",
//                     image: AppAssets.changePassword,
//                     sold: "5"),
//               ),
//             ),
//             spacer24,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   AppStrings.revenueGraph,
//                   style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             spacer20,
//             Card(
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(19)),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10),
//                           margin: const EdgeInsets.all(8),
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: AppColors.cardLightGrey,
//                               borderRadius:
//                               BorderRadius.circular(30)),
//                           child: Row(
//                             children: const [
//                               Text("This Week"),
//                               Icon(Icons.keyboard_arrow_down_outlined)
//                             ],
//                           ))
//                     ],
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     width: 350,
//                     height: 300,
//                     child: Chart(
//                       data: basicData,
//                       variables: {
//                         'genre': Variable(
//                           accessor: (Map map) =>
//                           map['genre'] as String,
//                         ),
//                         'sold': Variable(
//                           accessor: (Map map) => map['sold'] as num,
//                         ),
//                       },
//                       elements: [
//                         IntervalElement(
//                           label: LabelAttr(
//                               encoder: (tuple) =>
//                                   Label(tuple['sold'].toString())),
//                           elevation:
//                           ElevationAttr(value: 0, updaters: {
//                             'tap': {true: (_) => 5}
//                           }),
//                           color: ColorAttr(
//                               value: Defaults.primaryColor,
//                               updaters: {
//                                 'tap': {
//                                   false: (color) =>
//                                       color.withAlpha(100)
//                                 }
//                               }),
//                           selected: {
//                             'tap': {0}
//                           },
//                         )
//                       ],
//                       axes: [
//                         Defaults.horizontalAxis,
//                         Defaults.verticalAxis,
//                       ],
//                       selections: {'tap': PointSelection(dim: Dim.x)},
//                       tooltip: TooltipGuide(),
//                       crosshair: CrosshairGuide(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
