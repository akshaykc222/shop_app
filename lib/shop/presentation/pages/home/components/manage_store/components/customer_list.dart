import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/data/models/customer_model.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/customer_bloc/customer_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late CustomerBloc customerBloc;
  final sortValueListener = ValueNotifier(0);
  final scrollController = ScrollController();
  @override
  void initState() {
    customerBloc = CustomerBloc.get(context);
    customerBloc.add(GetCustomerEvent(context));
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      customerBloc.add(GetPaginatedCustomerEvent(context,
          dateSort: (sortValueListener.value == 0 ||
                  sortValueListener.value == 1 ||
                  sortValueListener.value == 2)
              ? null
              : sortValueListener.value == 3
                  ? "asc"
                  : "desc",
          alphaSort: (sortValueListener.value == 0 ||
                  sortValueListener.value == 3 ||
                  sortValueListener.value == 4)
              ? null
              : sortValueListener.value == 1
                  ? "asc"
                  : "desc"));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
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
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      AppStrings.customerList,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox())
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            spacer5,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            builder: (context, val, child) {
                              return Text(
                                sortValueListener.value == 0
                                    ? AppStrings.sort
                                    : sortValueListener.value == 1
                                        ? AppStrings.sortByAscending
                                        : sortValueListener.value == 2
                                            ? AppStrings.sortByDescending
                                            : sortValueListener.value == 3
                                                ? AppStrings.sortByDateAscending
                                                : AppStrings
                                                    .sortByDateDescending,
                                style: const TextStyle(color: AppColors.black),
                              );
                            },
                            valueListenable: sortValueListener,
                          ),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    onSelected: (index) {
                      sortValueListener.value = index;
                      customerBloc.add(GetCustomerEvent(context,
                          dateSort: (index == 0 || index == 1 || index == 2)
                              ? null
                              : index == 3
                                  ? "asc"
                                  : "desc",
                          alphaSort: (index == 0 || index == 3 || index == 4)
                              ? null
                              : index == 1
                                  ? "asc"
                                  : "desc"));
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(AppStrings.sortByAscending),
                                  // Icon(Icons.sort_by_alpha)
                                ],
                              )),
                          PopupMenuItem(
                              value: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(AppStrings.sortByDescending),
                                  // Icon(Icons.sort_by_alpha)
                                ],
                              )),
                          PopupMenuItem(
                              value: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(AppStrings.sortByDateAscending),
                                  // Icon(Icons.sort)
                                ],
                              )),
                          PopupMenuItem(
                              value: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(AppStrings.sortByDateDescending),
                                  // Icon(Icons.sort)
                                ],
                              )),
                        ])
              ],
            ),
            spacer5,
            Expanded(child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
                if (state is CustomerLoadingState) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            const CustomerCardShimmer()),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: customerBloc.customerList.length,
                    itemBuilder: (context, index) => CustomerCard(
                          model: customerBloc.customerList[index],
                        ));
              },
            ))
          ],
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final CustomerModel model;
  const CustomerCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Column(
                        children: [
                          spacer10,
                          Row(
                            children: [
                              Text(
                                "${model.fName} ${model.lName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AppColors.black),
                              ),
                            ],
                          ),
                          spacer10,
                          Row(
                            children: [
                              const Icon(
                                Icons.phone_android,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                model.phone == "" ? "-" : model.phone,
                                style: const TextStyle(
                                    fontSize: 13, color: AppColors.black),
                              )
                            ],
                          ),
                          spacer5,
                          Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  model.email,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColors.black),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            spacer10,
            Container(
              decoration: BoxDecoration(
                  color: AppColors.offWhite1,
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.only(left: 15, right: 8, top: 5),
              child: Column(
                children: [
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
                  // spacer5,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${model.totalOrders}",
                          style: const TextStyle(
                              color: AppColors.skyBlue,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                            future: getUserData(),
                            builder: (context, data) {
                              return Text(
                                "${data.data?.currency.position == "left" ? data.data?.currency.symbol : ""}" +
                                    " ${model.totalSales} ${data.data?.currency.position == "left" ? "" : data.data?.currency.symbol}",
                                style: const TextStyle(
                                    color: AppColors.skyBlue,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              );
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerCardShimmer extends StatelessWidget {
  const CustomerCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            spacer10,
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
            spacer9,
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.white,
                )
              ],
            ),
            spacer20,
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 80,
                    height: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Container(
                  width: 80,
                  height: 15,
                  color: Colors.white,
                ))
              ],
            ),
            spacer10,
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
