import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/ripple_round.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _makingPhoneCall() async {
      var url = Uri.parse("tel:9776765434");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Order # 56454"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditOrder()));
                },
                child: const Text(
                  AppStrings.editOrder,
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.white70,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const RejectOrder())
                    },
                child: const Text(
                  AppStrings.rejectOrder,
                  style: TextStyle(color: Colors.red),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 45,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const AcceptOrder());
                  },
                  child: const Text(
                    AppStrings.acceptOrder,
                    style: TextStyle(fontSize: 16),
                  )),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "1 ITEM",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "RECEIPT",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
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
                            width: 100,
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
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
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
                  children: const [
                    Text(AppStrings.delivery),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '₹15',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
              spacer10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.customerDetails,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 18,
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
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppStrings.share.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.blue,
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [Text("sdfsdf"), Text("+91-7907017542")],
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          AppStrings.address,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text("fsdfdsfdf")
                      ],
                    ),
                  ],
                ),
              ),
              spacer20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    ItemCard(title: AppStrings.state, value: "Kerala"),
                  ],
                ),
              ),
              spacer20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        spacer5,
        Text(
          value,
          style: const TextStyle(),
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
            const Text(AppStrings.acceptDesc),
            spacer20,
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
            const Text(AppStrings.rejectDesc),
            spacer20,
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
