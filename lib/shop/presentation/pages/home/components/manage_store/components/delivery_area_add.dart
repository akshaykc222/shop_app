import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/shop/data/models/region_model.dart';
import 'package:shop_app/shop/presentation/manager/bloc/manage_store_bloc/delivery_area_bloc/delivery_area_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_strings.dart';
import '../../../../../widgets/custom_switch.dart';

class DeliveryAreaAdd extends StatefulWidget {
  final RegionData? id;

  const DeliveryAreaAdd({this.id, super.key});

  @override
  State<DeliveryAreaAdd> createState() => _DeliveryAreaAddState();
}

class _DeliveryAreaAddState extends State<DeliveryAreaAdd> {
  final nameController = TextEditingController();
  final pinCodeController = TextEditingController();
  final deliveryCharge = TextEditingController(text: "0");
  final cod = ValueNotifier(false);
  final da = ValueNotifier(true);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? selectedLocation;
  Set<Marker> markers = {};
  late DeliveryAreaBloc blocState;

  @override
  void initState() {
    blocState = DeliveryAreaBloc.get(context);
    if (widget.id != null) {
      nameController.text = widget.id?.name ?? "";
      pinCodeController.text = widget.id?.pinCode ?? "";
      deliveryCharge.text = widget.id?.deliveryCharge.toString() ?? "";
      cod.value = widget.id?.deliveryAvialble ?? false;
      da.value = widget.id?.deliveryAvialble ?? true;
      blocState.add(ChooseLocationEvent(
          LatLng(widget.id?.latitude ?? 0, widget.id?.longitude ?? 0),
          context));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ))),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Add Delivery Area",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              const Expanded(child: SizedBox())
            ],
          )),
      bottomNavigationBar: BlocBuilder<DeliveryAreaBloc, DeliveryAreaState>(
          builder: (context, state) {
        return state is DeliveryAreaLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    if (blocState.selectedLocation != null &&
                        blocState.placeMarks.isNotEmpty) {
                      blocState.add(AddRegionEvent(
                          context,
                          RegionData(
                            id: widget.id?.id,
                            name: nameController.text,
                            pinCode:
                                blocState.placeMarks.first.postalCode ?? "",
                            codAvialble: cod.value,
                            latitude: blocState.selectedLocation!.latitude,
                            longitude: blocState.selectedLocation!.longitude,
                            deliveryAvialble: da.value,
                            deliveryCharge:
                                double.tryParse(deliveryCharge.text) ?? 0,
                            estDeliveryTime: 0,
                          )));
                    }
                  },
                  child: const Text(
                    AppStrings.save,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
              );
      }),
      body: BlocBuilder<DeliveryAreaBloc, DeliveryAreaState>(
        builder: (context, state) {
          if (blocState.placeMarks.isNotEmpty) {
            print(blocState.placeMarks.first.toJson());
            nameController.text = blocState.placeMarks.first.street ?? "";
            pinCodeController.text =
                blocState.placeMarks.first.postalCode ?? "";
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              children: [
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(AppPages.locationSelect);
                    },
                    icon: const Row(
                      children: [
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Select Location")
                      ],
                    )),
                CommonTextField(
                  title: 'Name',
                  controller: nameController,
                  enable: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  title: 'Pin Code',
                  controller: pinCodeController,
                  textInputType: TextInputType.number,
                  maxLength: 6,
                  enable: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'COD : ',
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w600),
                          ),
                          ValueListenableBuilder(
                              valueListenable: cod,
                              builder: (context, data, child) {
                                return CustomSwitch(
                                  value: data,
                                  onChanged: (val) {
                                    cod.value = val;
                                  },
                                  enableColor: AppColors.green,
                                  disableColor: AppColors.pink,
                                );
                              })
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Delivery Available : ',
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w600),
                          ),
                          ValueListenableBuilder(
                              valueListenable: da,
                              builder: (context, data, child) {
                                return CustomSwitch(
                                  value: data,
                                  onChanged: (val) {
                                    da.value = val;
                                  },
                                  enableColor: AppColors.green,
                                  disableColor: AppColors.pink,
                                );
                              })
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  title: 'Deliver  Charge',
                  controller: deliveryCharge,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
