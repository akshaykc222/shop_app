import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/custom_switch.dart';

import '../../../../../themes/app_assets.dart';

class StoreTimingScreen extends StatelessWidget {
  const StoreTimingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    AppStrings.storeTiming,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox())
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer26,
              const Text(
                AppStrings.hours,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              spacer17,
              const Text(
                AppStrings.yourStoreWillAutoDesc,
                style: TextStyle(fontSize: 15, color: AppColors.greyText),
              ),
              spacer18,
              ListView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => HoursSelectTile(
                        day: WeekDays.values[index].name,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
// class HoursSelectTile extends StatelessWidget {
//   const HoursSelectTile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: AppColors.lightBorderColor)),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.calendar_month,
//             color: AppColors.black,
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           const Text(
//             "Sunday",
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//           ),
//           const Spacer(),
//           const Text(
//             "Closed",
//             style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.lightBorderColor,
//                 fontWeight: FontWeight.normal),
//           ),
//           const SizedBox(
//             width: 9,
//           ),
//           CustomSwitch(
//             value: true,
//             onChanged: (val) {},
//             enableColor: AppColors.green,
//           )
//         ],
//       ),
//     );
//   }
// }

class HoursSelectTile extends StatefulWidget {
  final String day;
  const HoursSelectTile({Key? key, required this.day}) : super(key: key);

  @override
  State<HoursSelectTile> createState() => _HoursSelectTileState();
}

class _HoursSelectTileState extends State<HoursSelectTile> {
  bool shopClosed = true;
  bool _24Selected = true;
  String selTime = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightBorderColor)),
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AppAssets.calender,
                width: 17,
                height: 15,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "${widget.day[0].toUpperCase()}${widget.day.substring(1)}",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                shopClosed ? "Open" : "Closed",
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.lightBorderColor,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 9,
              ),
              CustomSwitch(
                value: shopClosed,
                onChanged: (val) {
                  setState(() {
                    shopClosed = !shopClosed;
                  });
                },
                disableColor: AppColors.red,
                enableColor: AppColors.green,
              )
            ],
          ),
          !shopClosed
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 27.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton<int>(
                          child: Row(
                            children: [
                              Image.asset(
                                AppAssets.clock,
                                width: 17,
                                height: 15,
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              const Text(
                                "24 Hours",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 17,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                          onSelected: (pos) {
                            prettyPrint("position $pos");
                            if (pos == 1) {
                              setState(() {
                                _24Selected = false;
                              });
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute));
                            }
                          },
                          itemBuilder: (context) => const [
                                PopupMenuItem(
                                    value: 0,
                                    child: Text(AppStrings.twentyFourHrs)),
                                PopupMenuItem(
                                    value: 1, child: Text("Select Time"))
                              ]),
                      _24Selected ? Container() : const Text("-"),
                      _24Selected
                          ? Container()
                          : PopupMenuButton<int>(
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.clock,
                                    width: 17,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  const Text(
                                    "24 Hours",
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                              onSelected: (pos) {
                                prettyPrint("position $pos");
                                if (pos == 1) {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute));
                                }
                              },
                              itemBuilder: (context) => const [
                                    PopupMenuItem(
                                        value: 0,
                                        child: Text(AppStrings.twentyFourHrs)),
                                    PopupMenuItem(
                                        value: 1, child: Text("Select Time"))
                                  ])
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
