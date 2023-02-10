import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/delivery_bloc/delivery_man_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

import '../../../../../../domain/entities/deliveryman_entity.dart';

class DeliveryManList extends StatefulWidget {
  const DeliveryManList({Key? key}) : super(key: key);

  @override
  State<DeliveryManList> createState() => _DeliveryManListState();
}

class _DeliveryManListState extends State<DeliveryManList>
    with TickerProviderStateMixin {
  late DeliveryManBloc deliveryManBloc;
  late ValueNotifier<bool> showSearchNotifier;
  late Animation expandingAnimation, transformAnimation, colorAnimation;
  late AnimationController expandingAnimationController;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    deliveryManBloc = DeliveryManBloc.get(context);
    showSearchNotifier = ValueNotifier(false);
    deliveryManBloc.searchTextController.clear();
    deliveryManBloc.add(GetDeliveryManListEvent(context: context, sort: "asc"));
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      deliveryManBloc.add(GetPaginatedDeliveryManEvent(context));
    }
  }

  @override
  void didChangeDependencies() {
    expandingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    expandingAnimation =
        Tween<double>(begin: 50, end: MediaQuery.of(context).size.width)
            .animate(CurvedAnimation(
                parent: expandingAnimationController,
                curve: Curves.easeInBack));
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
    // deliveryManBloc.initialCountryCode.dispose();

    // deliveryManBloc.selectedDropDown.dispose();

    showSearchNotifier.dispose();
    expandingAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 70),
        child: AnimatedBuilder(
          animation: expandingAnimationController,
          builder: (BuildContext context, Widget? child) {
            return ValueListenableBuilder(
                valueListenable: showSearchNotifier,
                builder: (context, search, child) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColors.offWhite1,
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          showSearchNotifier.value
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 8),
                                          child: SizedBox(
                                            height: 55,
                                            child: TextFormField(
                                              // enabled: false,
                                              controller: deliveryManBloc
                                                  .searchTextController,
                                              onFieldSubmitted: (val) {
                                                deliveryManBloc.add(
                                                    GetDeliveryManListEvent(
                                                        context: context,
                                                        sort: "desc",
                                                        search: val));
                                              },
                                              textInputAction:
                                                  TextInputAction.search,
                                              decoration: const InputDecoration(
                                                  hintText: "Search ... ",
                                                  border:
                                                      UnderlineInputBorder()),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        showSearchNotifier.value = false;
                                        deliveryManBloc.searchTextController
                                            .clear();
                                        deliveryManBloc.add(
                                            GetDeliveryManListEvent(
                                                context: context, sort: "asc"));
                                      },
                                    ))
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          icon: const Icon(Icons.arrow_back),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            AppStrings.deliveryMan,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            showSearchNotifier.value = true;
                                            // showSearchNotifier.notifyListeners();
                                          },
                                          icon: Image.asset(
                                            AppAssets.search,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ))
                                  ],
                                ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deliveryManBloc.add(RefreshDeliveryManEvent());
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
            spacer5,
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
                PopupMenuButton<int>(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: const [
                          Text(
                            AppStrings.sort,
                            style:
                                TextStyle(fontSize: 15, color: AppColors.black),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                    onSelected: (val) {
                      switch (val) {
                        case 1:
                          deliveryManBloc.add(GetDeliveryManListEvent(
                              context: context, sort: "asc"));
                          break;
                        case 2:
                          deliveryManBloc.add(GetDeliveryManListEvent(
                              context: context, sort: "desc"));
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
            spacer5,
            Expanded(child: BlocBuilder<DeliveryManBloc, DeliveryManState>(
              builder: (context, state) {
                if (state is DeliveryManLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            const DeliverManListCardShimmer()),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: deliveryManBloc.deliveryManList.length + 1,
                    itemBuilder: (context, index) =>
                        deliveryManBloc.deliveryManList.length == index
                            ? deliveryManBloc.currentPage <
                                    deliveryManBloc.totalPage
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: const DeliverManListCardShimmer())
                                : Container()
                            : DeliverManListCard(
                                model: deliveryManBloc.deliveryManList[index],
                              ));
              },
            ))
          ],
        ),
      ),
    );
  }
}

class DeliverManListCard extends StatelessWidget {
  final DeliveryManEntity model;
  const DeliverManListCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppPages.deliverymanEdit,
            params: {"id": model.id.toString()});
      },
      child: Card(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            onError: (err, r) => Image.asset(AppAssets.error),
                            image: CachedNetworkImageProvider(model.image))),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      spacer10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            model.email,
                            style: const TextStyle(
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
                      spacer5,
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            model.phone,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10.0, bottom: 5, right: 10),
              decoration: BoxDecoration(
                  color: AppColors.offWhite1,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "${AppStrings.totalOrdersSaved} :",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black),
                  ),
                  Text(
                    "${model.totalOrderCount}",
                    style: const TextStyle(
                        color: AppColors.skyBlue, fontWeight: FontWeight.w600),
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

class DeliverManListCardShimmer extends StatelessWidget {
  const DeliverManListCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        color: Colors.white.withOpacity(0.1),
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
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 15,
                        color: Colors.white,
                      ),
                      spacer10,
                      Container(
                        width: 140,
                        height: 15,
                        color: Colors.white,
                      ),
                      spacer5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Image.asset(
                              AppAssets.edit,
                              color: Colors.white,
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
                children: [
                  Container(
                    width: 120,
                    height: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
