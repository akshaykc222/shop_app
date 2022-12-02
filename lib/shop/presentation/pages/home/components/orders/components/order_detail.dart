import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OrderBloc.get(context);
    _makingPhoneCall() async {
      var url = Uri.parse("tel:9776765434");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Oder #154484",
                  maxLines: 1,
                  textWidthBasis: null,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              IconButton(
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
                  ))
            ],
          )),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
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
                            builder: (context) => const RejectOrder())
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
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20)))),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const AcceptOrder());
                    },
                    child: const Text(
                      AppStrings.acceptOrder,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              spacer10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Order # 5670125",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Row(
                      children: const [
                        SizedBox(width: 20, height: 20, child: RippleButton()),
                        Text(
                          "Pending",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(),
              ),
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
                        children: const <TextSpan>[
                          TextSpan(
                              text: '2',
                              style: TextStyle(
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
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.orderProductCount,
                          itemBuilder: (context, index) =>
                              const OrderProducts());
                    },
                  ),
                ],
              ),
              spacer26,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      AppStrings.itemTotal,
                      style: TextStyle(
                          color: AppColors.offWhiteTextColor, fontSize: 15),
                    ),
                    Text(
                      '15 AED',
                      style: TextStyle(
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
                      children: [
                        const Text(
                          AppStrings.delivery,
                          style: TextStyle(
                              color: AppColors.offWhiteTextColor, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 23,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(
                                  color: AppColors.offWhite1, width: 2),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                            child: Text("0"),
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
              spacer14,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      AppStrings.grandTotal,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      '15 AED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primaryColor),
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "sdfsdf",
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "+91-7907017542",
                          style: TextStyle(
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
                            _makingPhoneCall();
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
                                'https://wa.me/=+917907017542?text=hi'))) {
                              await launchUrl(Uri.parse(
                                  'https://wa.me/=+917907017542?text=hi'));
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          AppStrings.address,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.offWhiteTextColor),
                        ),
                        Text("fsdfdsfdf",
                            style: TextStyle(
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ItemCard(title: AppStrings.localityArea, value: "hjjiji"),
                    SizedBox(
                      width: 50,
                    ),
                    ItemCard(title: AppStrings.landMark, value: "Landmarkd="),
                  ],
                ),
              ),
              spacer20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ItemCard(title: AppStrings.city, value: "hjjiji"),
                    SizedBox(
                      width: 120,
                    ),
                    ItemCard(title: AppStrings.pinCode, value: "680674"),
                  ],
                ),
              ),
              spacer20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: const [
                    ItemCard(title: AppStrings.state, value: "Kerala"),
                  ],
                ),
              ),
              spacer20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ItemCard(title: AppStrings.payment, value: "Kerala"),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "COD",
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
  const AcceptOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  const RejectOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
