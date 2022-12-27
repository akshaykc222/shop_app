import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/domain/entities/store_timing_entity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/hour_tile_cubit/cubit/store_timing_cubit.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/custom_switch.dart';

import '../../../../../themes/app_assets.dart';

class StoreTimingScreen extends StatefulWidget {
  const StoreTimingScreen({Key? key}) : super(key: key);

  @override
  State<StoreTimingScreen> createState() => _StoreTimingScreenState();
}

class _StoreTimingScreenState extends State<StoreTimingScreen> {
  late StoreTimingCubit controller;
  @override
  void initState() {
    controller = StoreTimingCubit.get(context);
    controller.getTiming();
    super.initState();
  }

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
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        controller.updateTiming();
                      },
                      icon: const Icon(
                        Icons.done,
                        color: AppColors.black,
                      )))
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
              BlocBuilder<StoreTimingCubit, StoreTimingState>(
                builder: (context, state) {
                  return state is StoreTimeLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: ListView.builder(
                              itemCount: 7,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  const HoursShimmerTile()),
                        )
                      : ListView.builder(
                          itemCount: controller.timingList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => HoursListTile(
                              entity: controller.timingList[index]));
                },
              )
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

class HoursShimmerTile extends StatelessWidget {
  const HoursShimmerTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightBorderColor)),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AppAssets.calender,
                width: 17,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 150,
                height: 15,
                color: Colors.white,
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 15,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              const SizedBox(
                width: 9,
              ),
              Container(
                width: 30,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HoursListTile extends StatefulWidget {
  final StoreTimingEntity entity;
  const HoursListTile({super.key, required this.entity});

  @override
  State<HoursListTile> createState() => _HoursListTileState();
}

class _HoursListTileState extends State<HoursListTile> {
  late ValueNotifier<StoreTimingEntity> _entity;

  @override
  void initState() {
    _entity = ValueNotifier(widget.entity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StoreTimingEntity>(
        valueListenable: _entity,
        builder: (context, val, child) {
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
                      val.day,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      val.open ? "Open" : "Closed",
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.lightBorderColor,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    CustomSwitch(
                      value: val.open,
                      onChanged: (val) {
                        _entity.value.open = !_entity.value.open;
                        _entity.notifyListeners();
                      },
                      disableColor: AppColors.red,
                      enableColor: AppColors.green,
                    )
                  ],
                ),
                val.open != true
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
                                    Text(
                                      _entity.value.openingTime != null
                                          ? DateFormat.jm().format(
                                              _entity.value.openingTime!)
                                          : AppStrings.twentyFourHrs,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                                onSelected: (pos) async {
                                  prettyPrint("position $pos");
                                  if (pos == 1) {
                                    _entity.value.is24Open = false;

                                    var time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: DateTime.now().hour,
                                            minute: DateTime.now().minute));
                                    if (time != null) {
                                      _entity.value.openingTime =
                                          formatTimeOfDay(time);
                                      _entity.value.closingTime = _entity
                                          .value.openingTime
                                          ?.add(const Duration(hours: 8));
                                    } else {
                                      _entity.value.is24Open = true;
                                    }
                                    _entity.notifyListeners();
                                  } else {
                                    _entity.value.openingTime = null;
                                    _entity.value.is24Open = true;
                                    _entity.notifyListeners();
                                  }
                                },
                                itemBuilder: (context) => const [
                                      PopupMenuItem(
                                          value: 0,
                                          child:
                                              Text(AppStrings.twentyFourHrs)),
                                      PopupMenuItem(
                                          value: 1, child: Text("Select Time"))
                                    ]),
                            val.is24Open == true || val.is24Open == null
                                ? Container()
                                : const Text("-"),
                            val.is24Open == true || val.is24Open == null
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
                                        Text(
                                          val.closingTime != null
                                              ? DateFormat.jm().format(
                                                  _entity.value.closingTime!)
                                              : "Select",
                                          style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Icon(
                                            Icons.keyboard_arrow_down_rounded)
                                      ],
                                    ),
                                    onSelected: (pos) async {
                                      if (pos == 1) {
                                        if (_entity.value.openingTime != null) {
                                          var time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: _entity
                                                      .value.openingTime!
                                                      .add(const Duration(
                                                          hours: 8))
                                                      .hour,
                                                  minute:
                                                      DateTime.now().minute));
                                          if (time != null) {
                                            _entity.value.closingTime =
                                                formatTimeOfDay(time);

                                            _entity.notifyListeners();
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Select starting time")));
                                        }
                                      } else {}
                                    },
                                    itemBuilder: (context) => const [
                                          // PopupMenuItem(
                                          //     value: 0,
                                          //     child: Text(
                                          //         AppStrings.twentyFourHrs)),
                                          PopupMenuItem(
                                              value: 1,
                                              child: Text("Select Time"))
                                        ])
                          ],
                        ),
                      )
              ],
            ),
          );
        });
  }
}
