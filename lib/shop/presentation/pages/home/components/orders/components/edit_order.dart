import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../../data/models/order_detail_model.dart';
import '../../../../../utils/app_constants.dart';

class EditOrder extends StatelessWidget {
  const EditOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppPages.addNewOrderProduct);
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      appBar: getAppBar(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                    size: 25,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.editOrder,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return state is OrderLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          onPressed: () {
                            if (controller.model != null) {
                              controller.add(ChangeOrderProductsEvent(context,
                                  controller.model!.orderId.toString()));
                            }
                          },
                          icon: const Icon(Icons.done));
                },
              )
            ],
          )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet(
      //         context: context, builder: (context) => AddProduct());
      //   },
      //   child: const Icon(Icons.add),
      // ),
      // bottomNavigationBar: SizedBox(
      //   height: 70,
      //   child: Column(
      //     children: [
      //       const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 10.0),
      //         child: Divider(
      //           color: Colors.grey,
      //         ),
      //       ),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width * 0.95,
      //         height: 45,
      //         child: ElevatedButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             child: const Text(AppStrings.requestConfirm)),
      //       )
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return state is OrderDetailsLoaded
                ? Column(
                    children: [
                      spacer30,
                      // TextButton(
                      //     onPressed: () {}, child: const Text(AppStrings.addNewProduct)),
                      // spacer10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Items : ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black.withOpacity(0.43)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${state.model.itemCount}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      spacer30,
                      Wrap(
                        children: [
                          BlocBuilder<OrderBloc, OrderState>(
                            builder: (context, state) {
                              return state is OrderDetailsLoaded
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.model.productDetails.length,
                                      itemBuilder: (context, index) =>
                                          OrderProducts(
                                            showEdit: true,
                                            model: state
                                                .model.productDetails[index],
                                          ))
                                  : Container();
                            },
                          ),
                        ],
                      ),
                      spacer20,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      spacer26,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.itemTotal,
                              style: TextStyle(
                                  color: AppColors.offWhiteTextColor,
                                  fontSize: 15),
                            ),
                            Text(
                              '${controller.getGrandTotal()} AED',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.offWhiteTextColor),
                            )
                          ],
                        ),
                      ),
                      spacer18,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  AppStrings.delivery,
                                  style: TextStyle(
                                      color: AppColors.offWhiteTextColor,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Container(
                                //   width: 50,
                                //   height: 23,
                                //   decoration: BoxDecoration(
                                //       color: AppColors.white,
                                //       border: Border.all(
                                //           color: AppColors.offWhite1, width: 2),
                                //       borderRadius: BorderRadius.circular(6)),
                                //   child: const Center(
                                //     child: Text("0"),
                                //   ),
                                // )
                              ],
                            ),
                            const Text(
                              'Free',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      spacer14,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.grandTotal,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              '${controller.getGrandTotal()} AED',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

class EditQty extends StatelessWidget {
  const EditQty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return Wrap(
      children: [
        spacer10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.editQuantity,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(2)),
                        child: Center(
                          child: Text(controller.orderQty.toString()),
                        ),
                      );
                    },
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
                  const Spacer(),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Text(
                        controller.orderAmt.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              spacer10,
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.26,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(AppStrings.confirm))),
              spacer30
            ],
          ),
        )
      ],
    );
  }
}

class EditDeliveryCharge extends StatelessWidget {
  const EditDeliveryCharge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              spacer10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.editDeliveryCharge,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const CommonTextField(
                title: AppStrings.editDeliveryCharge,
                required: true,
              ),
              spacer10,
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(AppStrings.change))),
              spacer10
            ],
          ),
        )
      ],
    );
  }
}

class OrderProducts extends StatefulWidget {
  final bool? showEdit;
  final OrderProductModel model;
  const OrderProducts({Key? key, this.showEdit, required this.model})
      : super(key: key);

  @override
  State<OrderProducts> createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  late ValueNotifier<int> qtyValueNotifier;
  late OrderBloc orderBloc;
  @override
  void initState() {
    qtyValueNotifier = ValueNotifier(widget.model.qty);
    orderBloc = OrderBloc.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 18),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.offWhite1,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 17.0),
                        child: Container(
                          width: 82,
                          height: 82,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.model.image))),
                        ),
                      ),
                      spacer10,
                      widget.showEdit == true
                          ? ValueListenableBuilder(
                              valueListenable: qtyValueNotifier,
                              builder: (context, data, child) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (qtyValueNotifier.value > 0) {
                                          qtyValueNotifier.value--;
                                          orderBloc.changeQty(
                                              qty: qtyValueNotifier.value,
                                              orderProductModel: widget.model);
                                        }
                                      },
                                      child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Center(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.52)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      width: 23,
                                      height: 23,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          qtyValueNotifier.value.toString(),
                                          style: const TextStyle(
                                              color: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        qtyValueNotifier.value++;
                                        orderBloc.changeQty(
                                            qty: qtyValueNotifier.value,
                                            orderProductModel: widget.model);
                                      },
                                      child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.52)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : Container()
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.model.name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    widget.showEdit == true
                                        ? GestureDetector(
                                            onTap: () {
                                              orderBloc
                                                  .removeProduct(widget.model);
                                            },
                                            child: Image.asset(
                                              AppAssets.delete,
                                              width: 16,
                                              height: 21,
                                            ))
                                        : Container()
                                  ],
                                ),
                                spacer10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Size : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black
                                                .withOpacity(0.52)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: widget.model.unit,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox()
                                    // Row(
                                    //   children: [
                                    //     Text("Colour : ",
                                    //         style: TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.w600,
                                    //             color: AppColors.black
                                    //                 .withOpacity(0.52))),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Container(
                                    //       width: 18,
                                    //       height: 18,
                                    //       decoration: BoxDecoration(
                                    //           color: Colors.red,
                                    //           borderRadius:
                                    //               BorderRadius.circular(2)),
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                ),
                                spacer10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Qty : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black
                                                .withOpacity(0.52)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '${widget.model.qty}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black)),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Price : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black
                                                .withOpacity(0.52)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '${widget.model.price}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                spacer10,
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    ValueListenableBuilder(
                                      builder: (context, data, child) {
                                        return RichText(
                                          text: TextSpan(
                                            text: ' Total Price : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black
                                                    .withOpacity(0.52)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${widget.model.price * qtyValueNotifier.value} AED',
                                                  style: const TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryColor)),
                                            ],
                                          ),
                                        );
                                      },
                                      valueListenable: qtyValueNotifier,
                                    ),
                                  ],
                                ),
                                spacer20
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.addNewProduct,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close))
                ],
              ),
              spacer10,
              const CommonTextField(title: "Select product"),
              spacer20,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      controller.changeOrderProductCount(
                          controller.orderProductCount + 1);

                      controller.add(AddOrderProduct());
                      Navigator.pop(context);
                    },
                    child: const Text(AppStrings.add)),
              ),
              spacer20
            ],
          ),
        ],
      ),
    );
  }
}
