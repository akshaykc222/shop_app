import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/domain/entities/order_entity_request.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/ripple_round.dart';

import '../../../../../data/models/order_listing_model.dart';
import '../../../../themes/app_assets.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_strings.dart';
import '../../../../widgets/custom_app_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late OrderBloc controller;
  final searchController = TextEditingController();
  late Animation expandingAnimation, transformAnimation, colorAnimation;
  late AnimationController expandingAnimationController;
  late ValueNotifier<bool> showSearchNotifier;
  final scrollController = ScrollController();
  @override
  void initState() {
    controller = OrderBloc.get(context);
    controller.add(GetOrderEvent(context));
    showSearchNotifier = ValueNotifier(false);
    WidgetsBinding.instance.addObserver(this);
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.add(GetPaginatedOrderEvent(
          context: context,
          request: OrderEntityRequest(
              pageNo: '0',
              search: searchController.text,
              status: controller.selectedFilter?.status)));
    }
  }

  @override
  void didChangeDependencies() {
    expandingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    expandingAnimation =
        Tween<double>(begin: 50, end: MediaQuery.of(context).size.width)
            .animate(CurvedAnimation(
                parent: expandingAnimationController, curve: Curves.easeInBack))
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward) {
            } else if (status == AnimationStatus.reverse) {}
          });
    transformAnimation = BorderRadiusTween(
            begin: const BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            end: const BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0)))
        .animate(CurvedAnimation(
            parent: expandingAnimationController, curve: Curves.easeIn));
    colorAnimation =
        ColorTween(begin: AppColors.primaryColor, end: AppColors.white).animate(
            CurvedAnimation(
                parent: expandingAnimationController, curve: Curves.easeIn));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // controller.add(GetOrderEvent(context));
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: AnimatedBuilder(
            animation: expandingAnimationController,
            builder: (BuildContext context, Widget? child) {
              return ValueListenableBuilder(
                  valueListenable: showSearchNotifier,
                  builder: (context, search, child) {
                    return !showSearchNotifier.value
                        ? getAppBar(
                            context,
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppStrings.orders,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      showSearchNotifier.value =
                                          !showSearchNotifier.value;
                                      expandingAnimationController.forward();
                                    },
                                    icon: Image.asset(
                                      AppAssets.search,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: 220)
                        : getAppBar(
                            context,
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 10),
                                  width: expandingAnimation.value,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: colorAnimation.value,
                                    borderRadius: transformAnimation.value,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: expandingAnimation.value < 200
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: SizedBox(
                                                    height: 55,
                                                    child: TextFormField(
                                                      controller:
                                                          searchController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Search ... ",
                                                              border:
                                                                  UnderlineInputBorder()),
                                                      onFieldSubmitted: (val) {
                                                        controller.add(
                                                            SearchOrderEvent(
                                                                searchController
                                                                    .text,
                                                                context:
                                                                    context));
                                                      },
                                                    ),
                                                  ),
                                                )),
                                      Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  controller.add(
                                                      SearchOrderEvent(
                                                          searchController.text,
                                                          context: context));
                                                },
                                                icon: Image.asset(
                                                  AppAssets.search,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    expandingAnimationController
                                                        .reverse()
                                                        .then((value) =>
                                                            showSearchNotifier
                                                                    .value =
                                                                !showSearchNotifier
                                                                    .value);
                                                    searchController.clear();
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: AppColors.black,
                                                    size: 25,
                                                  )),
                                            ]),
                                      )
                                    ],
                                  ),
                                )));
                  });
            },
          ),
        ),
        // backgroundColor: AppColors.white,
        body: Column(
          children: [
            spacer20,
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              const StatusLoadingShimmer()),
                    ),
                  );
                }
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
                              controller.add(SearchOrderEvent(
                                  searchController.text,
                                  context: context,
                                  status: controller.statusList[index].status));
                              controller.changeSelectedFilter(
                                  controller.statusList[index]);
                              controller.add(ChangeTagEvent());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 6, top: 6),
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
                                controller.statusList[index].statusName ?? "",
                                style: TextStyle(
                                    fontSize: 15,
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
            spacer20,
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.allOrders,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  PopupMenuButton<int>(
                      child: Row(
                        children: const [
                          Text(
                            AppStrings.sort,
                            style: TextStyle(
                                fontSize: 15, color: AppColors.greyText),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                      onSelected: (val) {
                        switch (val) {
                          case 1:
                            break;
                          case 2:
                            break;
                        }
                      },
                      itemBuilder: (context) => const [
                            PopupMenuItem(
                                value: 1,
                                child: Text(AppStrings.sortByDateAscending)),
                            PopupMenuItem(
                                value: 2,
                                child: Text(AppStrings.sortByDateDescending))
                          ]),
                ],
              ),
            ),
            spacer24,
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return Flexible(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              const OrderListShimmer()),
                    ),
                  );
                }
                return controller.orderList.isEmpty
                    ? Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
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
                            // const SizedBox(
                            //   height: 2,
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20.0),
                            //   child: Text(
                            //     AppStrings.shareYourStoreLink,
                            //     textAlign: TextAlign.center,
                            //     style: Theme.of(context).textTheme.bodySmall,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.65,
                            //   height: 50,
                            //   child: OutlinedButton(
                            //       onPressed: () {
                            //         Share.share('hi',
                            //             subject: 'Look what I made!');
                            //       },
                            //       child: const Text(
                            //         AppStrings.shareYourStore,
                            //         style: TextStyle(fontSize: 18),
                            //       )),
                            // ),
                            // spacer20,
                            const Spacer(),
                          ],
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: controller.orderList.length + 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => controller
                                        .orderList.length ==
                                    index
                                ? controller.currentPage < controller.totalPages
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const OrderListShimmer())
                                    : Container()
                                : OrderListCard(
                                    model: controller.orderList[index])),
                      );
              },
            ),
          ],
        ));
  }
}

class OrderListCard extends StatelessWidget {
  final OrderModel model;
  const OrderListCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppPages.detail,
            params: {'id': model.orderId.toString()});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order # ${model.orderId}",
                    style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    getFormatedDate(model.orderDatetime),
                    style: const TextStyle(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Total Items :',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: model.itemCount.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    spacer10,
                    RichText(
                      text: TextSpan(
                        text: 'Total Price :',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${model.orderTotal} AED',
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Text(
                //       "1 ITEM",
                //       style: TextStyle(
                //           fontSize: 15,
                //           color: AppColors.black,
                //           fontWeight: FontWeight.w600),
                //     ),
                //     spacer10,
                //     const Text(
                //       "₹15",
                //       style: TextStyle(color: Colors.blue),
                //     )
                //   ],
                // ),
                const Spacer(),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      model.paymentMethod,
                      style: const TextStyle(
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
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: RippleButton(
                          color: getColor(
                              model.orderStatus, controller.statusList),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.orderStatus,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(AppPages.detail,
                          params: {'id': model.orderId.toString()});
                    },
                    child: SizedBox(
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
                          const SizedBox(
                            width: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Image.asset(
                              AppAssets.rightArrow,
                              width: 6,
                              height: 10,
                              fit: BoxFit.fill,
                            ),
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
      ),
    );
  }
}

class OrderListShimmer extends StatelessWidget {
  const OrderListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 15,
                  color: Colors.white,
                ),
                Container(
                  width: 80,
                  height: 15,
                  color: Colors.white,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 15,
                    color: Colors.white,
                  ),
                  spacer10,
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text(
              //       "1 ITEM",
              //       style: TextStyle(
              //           fontSize: 15,
              //           color: AppColors.black,
              //           fontWeight: FontWeight.w600),
              //     ),
              //     spacer10,
              //     const Text(
              //       "₹15",
              //       style: TextStyle(color: Colors.blue),
              //     )
              //   ],
              // ),
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: 50,
                    height: 15,
                    color: Colors.white,
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
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: RippleButton(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 80,
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
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
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Image.asset(
                          AppAssets.rightArrow,
                          width: 6,
                          height: 10,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
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

class StatusLoadingShimmer extends StatelessWidget {
  const StatusLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primaryColor, width: 1.2)),
      child: Container(
        width: 80,
        height: 10,
        color: Colors.white,
      ),
    );
  }
}
