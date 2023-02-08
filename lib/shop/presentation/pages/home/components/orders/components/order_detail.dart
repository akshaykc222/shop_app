import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/ripple_round.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../manager/bloc/order_bloc/order_bloc.dart';
import 'edit_order.dart';

@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late OrderBloc controller;

  _makingPhoneCall(String phone) async {
    var url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  late BuildContext _context;
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    _context = context;
    controller = OrderBloc.get(context);
    controller.add(GetOrderDetailEvent(context, int.parse(widget.id)));
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return state is OrderDetailsLoaded
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Order #${state.model.orderId}",
                            maxLines: 1,
                            textWidthBasis: null,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      : const SizedBox();
                },
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderDetailsLoaded) {
                    if (state.model.orderStatus.toLowerCase() !=
                        "Canceled".toLowerCase()) {
                      return IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditOrder()));
                          },
                          icon: Image.asset(
                            AppAssets.edit,
                            width: 20,
                            height: 20,
                          ));
                    }
                  }
                  return const SizedBox(
                    width: 20,
                    height: 20,
                  );
                },
              )
            ],
          )),
      bottomNavigationBar: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderDetailsLoaded) {
            if (state.model.orderStatus.toLowerCase() !=
                "Canceled".toLowerCase()) {
              return Container(
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.shade300,
                          offset: const Offset(0, -1))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () => {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => RejectOrder(
                                          ctx: _context,
                                        ))
                              },
                          child: const Text(
                            AppStrings.rejectOrder,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                disabledForegroundColor: Colors.white,
                                disabledBackgroundColor: Colors.grey,
                                backgroundColor: Colors.green,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20)))),
                            onPressed: state.model.orderStatus.toLowerCase() ==
                                    "confirmed".toLowerCase()
                                ? null
                                : () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            AcceptOrder(ctx: _context));
                                  },
                            child: const Text(
                              AppStrings.acceptOrder,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          return const SizedBox(
            height: 1,
          );
        },
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state is OrderLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : state is OrderDetailsLoaded
                  ? Stack(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            spacer10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order # ${state.model.orderId}",
                                    style: const TextStyle(
                                        color: AppColors.greyText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: RippleButton()),
                                      Text(
                                        state.model.orderStatus,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 4),
                              child: Divider(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Items : ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black
                                              .withOpacity(0.43)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '${state.model.itemCount}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black)),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var path =
                                          await getApplicationDocumentsDirectory();

                                      await FlutterDownloader.enqueue(
                                        url: state.model.receiptUrl,
                                        headers: {},
                                        savedDir: path.path,
                                        showNotification: true,
                                        openFileFromNotification: true,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.receipt,
                                          width: 18,
                                          height: 20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            AppStrings.receipt,
                                            style: TextStyle(
                                                color: AppColors.skyBlue,
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            spacer20,
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.model.productDetails.length,
                                itemBuilder: (context, index) => OrderProducts(
                                      model: state.model.productDetails[index],
                                    )),
                            spacer26,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    AppStrings.itemTotal,
                                    style: TextStyle(
                                        color: AppColors.offWhiteTextColor,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${state.model.grandTotal.toStringAsFixed(2)} AED',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.offWhiteTextColor),
                                  )
                                ],
                              ),
                            ),
                            spacer18,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      //           color: AppColors.offWhite1,
                                      //           width: 2),
                                      //       borderRadius:
                                      //           BorderRadius.circular(6)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    AppStrings.grandTotal,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    '${state.model.grandTotal.toStringAsFixed(2)} AED',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.skyBlue),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            spacer10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    AppStrings.customerDetails,
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share("demo");
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.share,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          AppStrings.share.toUpperCase(),
                                          style: const TextStyle(
                                              color: AppColors.skyBlue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.model.customerDetails.name,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "+91-${state.model.customerDetails.phone}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _makingPhoneCall(state
                                              .model.customerDetails.phone);
                                        },
                                        child: Image.asset(
                                          AppAssets.phone,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://wa.me/=+91${state.model.customerDetails.phone}?text=hi'))) {
                                            await launchUrl(Uri.parse(
                                                'https://wa.me/=+91${state.model.customerDetails.phone}?text=hi'));
                                          } else {
                                            throw 'Could not launch ';
                                          }
                                        },
                                        child: Image.asset(
                                          AppAssets.whatsApp,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        AppStrings.address,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: AppColors.offWhiteTextColor),
                                      ),
                                      Text(state.model.customerDetails.address,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: AppColors.black))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ItemCard(
                                      title: AppStrings.localityArea,
                                      value: state.model.customerDetails.city),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  ItemCard(
                                      title: AppStrings.landMark,
                                      value:
                                          state.model.customerDetails.locality),
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ItemCard(
                                      title: AppStrings.city,
                                      value: state.model.customerDetails.city),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  ItemCard(
                                      title: AppStrings.pinCode,
                                      value: state.model.customerDetails.zip),
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  ItemCard(
                                      title: AppStrings.state,
                                      value: state.model.customerDetails.state),
                                ],
                              ),
                            ),
                            spacer20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    AppStrings.payment,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.offWhiteTextColor,
                                        fontSize: 15),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 14),
                                      decoration: BoxDecoration(
                                          color: Colors.deepOrangeAccent
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        state.model.paymentMethod,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent),
                                      )),
                                ],
                              ),
                            ),
                            spacer20
                          ],
                        ),
                      ],
                    )
                  : const SizedBox();
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String value;
  const ItemCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.offWhiteTextColor,
              fontSize: 15),
        ),
        spacer5,
        Text(
          value,
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

class AcceptOrder extends StatelessWidget {
  final BuildContext ctx;

  const AcceptOrder({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = OrderBloc.get(context);
    return Wrap(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  AppAssets.smiley,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppStrings.acceptOrder,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            spacer20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(AppStrings.acceptDesc),
            ),
            spacer20,
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      orderBloc.add(ChangeStatusProductEvent(ctx, "confirmed"));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppStrings.yesAcceptOrder,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ))),
            spacer10
          ],
        )
      ],
    );
  }
}

class RejectOrder extends StatelessWidget {
  final BuildContext ctx;

  const RejectOrder({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = OrderBloc.get(context);
    return Wrap(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  AppAssets.sad,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppStrings.rejectOrder,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            spacer20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(AppStrings.rejectDesc),
            ),
            spacer20,
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      orderBloc.add(ChangeStatusProductEvent(ctx, "canceled"));
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      AppStrings.yesRejecttOrder,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ))),
            spacer10
          ],
        )
      ],
    );
  }
}
