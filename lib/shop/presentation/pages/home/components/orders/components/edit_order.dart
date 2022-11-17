import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/order_bloc/order_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';

import '../../../../../utils/app_constants.dart';

class EditOrder extends StatelessWidget {
  const EditOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.editOrder),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                AppStrings.close,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(AppStrings.requestConfirm)),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                onPressed: () {}, child: const Text(AppStrings.addNewProduct)),
            spacer10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "1 ITEM",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.orderProductCount,
                        itemBuilder: (context, index) => const OrderProducts());
                  },
                ),
              ],
            ),
            spacer20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(AppStrings.itemTotal),
                  Text(
                    '₹15',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            spacer5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(AppStrings.delivery),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => const EditDeliveryCharge());
                        },
                        child: const Text(
                          AppStrings.editFee,
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'Free',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.green),
                  )
                ],
              ),
            ),
            spacer10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    AppStrings.grandTotal,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '₹15',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  IconButton(
                      onPressed: () {
                        controller.changeQty(controller.orderQty + 1);
                        controller.add(ChangeQtyEvent());
                      },
                      icon: const Icon(Icons.add)),
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
                  IconButton(
                      onPressed: () {
                        controller.changeQty(controller.orderQty - 1);
                        controller.add(ChangeQtyEvent());
                      },
                      icon: const Icon(Icons.remove)),
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

class OrderProducts extends StatelessWidget {
  const OrderProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "p",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      spacer5,
                      const Text("Size: xl"),
                      Row(
                        children: [
                          const Text("Colour:"),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(2)),
                          )
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spa,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 23,
                                  height: 23,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                          color: Colors.blue.withOpacity(0.6)),
                                      color: Colors.blue.withOpacity(0.2)),
                                  child: const Center(
                                    child: Text(
                                      "1",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Text(
                                "X",
                                style: TextStyle(fontSize: 12),
                              ),
                              const Text(
                                "₹15",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                builder: (context) => const EditQty()),
                            child: const Text(
                              AppStrings.editQty,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            width: 75,
                          ),
                          const Text(
                            '₹15',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        final controller = OrderBloc.get(context);
                        controller.changeOrderProductCount(
                            controller.orderProductCount - 1);
                        controller.add(AddOrderProduct());
                      },
                      icon: const Icon(Icons.delete_outline))
                ],
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
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
