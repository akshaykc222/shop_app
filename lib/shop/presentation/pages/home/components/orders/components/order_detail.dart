import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';
import 'package:shop_app/shop/domain/enums.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/ripple_round.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../data/routes/hive_storage_name.dart';
import '../../../../../manager/bloc/order_bloc/order_bloc.dart';
import 'edit_order.dart';

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

  void _launchURL() async {
    String url = '${AppRemoteRoutes.baseUrl}api/v1/download_pdf/${widget.id}/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> getType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(LocalStorageNames.type) ?? false;
  }

  late BuildContext _context;
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    _context = context;
    controller = OrderBloc.get(context);
    controller.add(GetOrderDetailEvent(context, widget.id));
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   setState(() {});
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
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
                            "Order #${state.model.id}",
                            maxLines: 1,
                            textWidthBasis: null,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 12),
                          ),
                        )
                      : const SizedBox();
                },
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderDetailsLoaded) {
                    if (state.model.status.toLowerCase() !=
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
      bottomNavigationBar: FutureBuilder(
          future: getType(),
          builder: (context, data) {
            return !data.hasData
                ? const SizedBox()
                : BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is OrderDetailsLoaded) {
                        if (data.data == true &&
                            state.model.status.toLowerCase() ==
                                ProductStatus.ON_THE_WAY.name.toLowerCase()) {
                          return Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20)),
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
                                  child: SizedBox(
                                    height: 70,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            disabledForegroundColor:
                                                Colors.white,
                                            disabledBackgroundColor:
                                                Colors.grey,
                                            backgroundColor: Colors.green,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20)))),
                                        onPressed:
                                            state.model.status.toLowerCase() ==
                                                    "confirmed".toLowerCase()
                                                ? null
                                                : () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        builder: (context) =>
                                                            CompleteOrder(
                                                                ctx: _context));
                                                  },
                                        child: const Text(
                                          "Complete Order",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (state.model.status.toLowerCase() ==
                            ProductStatus.ORDERED.name.toLowerCase()) {
                          return Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20)),
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19)),
                                                builder: (context) =>
                                                    RejectOrder(
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
                                            disabledForegroundColor:
                                                Colors.white,
                                            disabledBackgroundColor:
                                                Colors.grey,
                                            backgroundColor: Colors.green,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20)))),
                                        onPressed:
                                            state.model.status.toLowerCase() ==
                                                    "confirmed".toLowerCase()
                                                ? null
                                                : () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        builder: (context) =>
                                                            AcceptOrder(
                                                                ctx: _context));
                                                  },
                                        child: const Text(
                                          AppStrings.acceptOrder,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (state.model.status.toLowerCase() ==
                            ProductStatus.ORDERED.name.toLowerCase()) {
                          return Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20)),
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19)),
                                                builder: (context) =>
                                                    DispatchOrder(
                                                      ctx: _context,
                                                    ))
                                          },
                                      child: const Text(
                                        AppStrings.dispatch,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return const SizedBox(
                        height: 1,
                      );
                    },
                  );
          }),
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
                                    "${DateFormat.yMMMEd().format(state.model.createdDate)}\t${DateFormat.jm().format(state.model.createdDate)}",
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: RippleButton(
                                            color: getColorFormStatus(),
                                          )),
                                      Text(
                                        state.model.status ?? "",
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
                                      text: 'Item(s) : ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black
                                              .withOpacity(0.43)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${state.model.cart.products.length}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black)),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      _launchURL();
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
                                itemCount: state.model.cart.products.length,
                                itemBuilder: (context, index) => OrderProducts(
                                      model: state.model.cart.products[index],
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
                                    AppStrings.paymentMethod,
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
                                        state.model.paymentRef.status,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent),
                                      )),
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
                                  const Text(
                                    AppStrings.itemTotal,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.offWhiteTextColor,
                                        fontSize: 15),
                                  ),
                                  FutureBuilder(
                                      future: getPositionedPrice(state
                                          .model.paymentRef.orderAmount
                                          .toStringAsFixed(2)),
                                      builder: (context, data) {
                                        return Text(
                                          data.data ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black),
                                        );
                                      })
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
                                  const Row(
                                    children: [
                                      Text(
                                        AppStrings.delivery,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
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
                                  Text(
                                    state.model.region?.deliveryCharge
                                            .toStringAsFixed(2) ??
                                        "0",
                                    style: const TextStyle(
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
                                  FutureBuilder(
                                      future: getPositionedPrice(state
                                          .model.paymentRef.orderAmount
                                          .toStringAsFixed(2)),
                                      builder: (context, data) {
                                        return Text(
                                          data.data ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppColors.skyBlue),
                                        );
                                      })
                                ],
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 30),
                            //   child: Divider(
                            //     thickness: 1,
                            //   ),
                            // ),
                            spacer10,
                            Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                children: [
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Transaction Id",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              state.model.paymentRef
                                                  .transactionId,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Type",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              state.model.paymentRef.type,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Status",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              state.model.paymentRef.status,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Status",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              state.model.paymentRef.status,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            spacer10,
                            Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                children: [
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Selected Date",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              DateFormat("dd/MM/yyyy").format(
                                                  state.model.orderDate),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Slot",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "${state.model.slot!.startTime}-${state.model.slot!.endTime}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                ],
                              ),
                            ),
                            spacer10,
                            Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                children: [
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          AppStrings.customerDetails,
                                          style: TextStyle(
                                              color: AppColors.greyText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Share.share("demo");
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.share,
                                                color: Colors.blue,
                                                size: 25,
                                              ),
                                              // const SizedBox(
                                              //   width: 5,
                                              // ),
                                              // Text(
                                              //   AppStrings.share.toUpperCase(),
                                              //   style: const TextStyle(
                                              //       color: AppColors.skyBlue,
                                              //       fontSize: 15,
                                              //       fontWeight:
                                              //           FontWeight.bold),
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.model.address.name,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              state.model.address.phoneNumber ??
                                                  "",
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
                                                _makingPhoneCall(state.model
                                                        .address.phoneNumber ??
                                                    "");
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
                                                    'https://wa.me/=+91${state.model.address.phoneNumber}?text=hi'))) {
                                                  await launchUrl(Uri.parse(
                                                      'https://wa.me/=+91${state.model.address.phoneNumber}?text=hi'));
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
                                  // Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(left: 30.0),
                                  //       child: Text(
                                  //         state.model.address.,
                                  //         style: const TextStyle(
                                  //             fontSize: 15,
                                  //             color: AppColors.black,
                                  //             fontWeight: FontWeight.w600),
                                  //       ),
                                  //     )),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
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
                                                  color: AppColors
                                                      .offWhiteTextColor),
                                            ),
                                            Text(state.model.address.address,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ItemCard(
                                            title: AppStrings.localityArea,
                                            value: state.model.address.address),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        // ItemCard(
                                        //     title: AppStrings.landMark,
                                        //     value: state.model.customerDetails
                                        //         .locality),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // ItemCard(
                                        //     title: AppStrings.city,
                                        //     value: state
                                        //         .model.customerDetails.city),
                                        // const SizedBox(
                                        //   width: 120,
                                        // ),
                                        // ItemCard(
                                        //     title: AppStrings.pinCode,
                                        //     value: state
                                        //         .model.customerDetails.zip),
                                      ],
                                    ),
                                  ),
                                  spacer20,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        // ItemCard(
                                        //     title: AppStrings.state,
                                        //     value: state
                                        //         .model.customerDetails.state),
                                      ],
                                    ),
                                  ),
                                  spacer20,

                                  // spacer20
                                ],
                              ),
                            ),
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
                    icon: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: AppColors.lightGrey, shape: BoxShape.circle),
                        child: const Icon(Icons.close)))
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
                      orderBloc.add(ChangeStatusProductEvent(
                          ctx, ProductStatus.ON_THE_WAY.name.toUpperCase()));
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

class CompleteOrder extends StatelessWidget {
  final BuildContext ctx;

  const CompleteOrder({Key? key, required this.ctx}) : super(key: key);

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
                  "Complete Order",
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
                    icon: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: AppColors.lightGrey, shape: BoxShape.circle),
                        child: const Icon(Icons.close)))
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
                      orderBloc.add(ChangeStatusProductEvent(
                          ctx, ProductStatus.DELIVERED.name.toUpperCase()));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Complete Order",
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
                  icon: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: AppColors.lightGrey, shape: BoxShape.circle),
                      child: const Icon(Icons.close)),
                ),
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
                      orderBloc.add(ChangeStatusProductEvent(
                          ctx, OrderStatus.ON_THE_WAY.name.toUpperCase()));
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

class DispatchOrder extends StatelessWidget {
  final BuildContext ctx;

  const DispatchOrder({Key? key, required this.ctx}) : super(key: key);

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
                  AppAssets.onTheWay,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppStrings.dispatch,
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
                  icon: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: AppColors.lightGrey, shape: BoxShape.circle),
                      child: const Icon(Icons.close)),
                ),
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
                      orderBloc.add(ChangeStatusProductEvent(
                          ctx, OrderStatus.ON_THE_WAY.name.toUpperCase()));
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      AppStrings.yesDispatchOrder,
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
