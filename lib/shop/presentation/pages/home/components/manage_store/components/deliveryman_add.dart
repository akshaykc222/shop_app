import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/delivery_bloc/delivery_man_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/select_image_and_crop.dart';
import '../../../../../widgets/custom_switch.dart';
import '../../../../../widgets/mandatory_text.dart';

class DeliveryManAdding extends StatefulWidget {
  final int? id;
  const DeliveryManAdding({Key? key, this.id}) : super(key: key);

  @override
  State<DeliveryManAdding> createState() => _DeliveryManAddingState();
}

class _DeliveryManAddingState extends State<DeliveryManAdding> {
  buildImageWidget({String? logo}) {
    return GestureDetector(
      onTap: () async {
        var result = await selectImageAndCropImage(
            context: context, title: AppStrings.uploadProductImage);
        if (result != null) {
          deliveryBloc.changeImage(result.path);
          image.value = result.path;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 38,
          ),
          ValueListenableBuilder(
            builder: (context, data, child) {
              return Container(
                width: 138,
                height: 138,
                decoration: BoxDecoration(
                    // color: AppColors.lightGrey,
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(19)),
                child: data == ""
                    ? logo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: CachedNetworkImage(imageUrl: logo))
                        : const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: AppColors.lightGrey,
                            ),
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Image.file(File(image.value))),
              );
            },
            valueListenable: image,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            AppStrings.addImage,
            style: TextStyle(
                color: AppColors.skyBlue, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  buildProofImageWidget({String? logo}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
          onTap: () async {
            var result = await selectImageAndCropImage(
                context: context, title: AppStrings.uploadProductImage);
            if (result != null) {
              deliveryBloc.identityImage = result.path;
              proofImage.value = result.path;
            }
          },
          child: ValueListenableBuilder(
            builder: (context, data, child) {
              return Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  // color: AppColors.lightGrey,
                  border: Border.all(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: data == ""
                    ? logo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: CachedNetworkImage(imageUrl: logo))
                        : const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: AppColors.lightGrey,
                            ),
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Image.file(
                          File(proofImage.value),
                          fit: BoxFit.fill,
                        ),
                      ),
              );
            },
            valueListenable: proofImage,
          )),
    );
  }

  ValueNotifier image = ValueNotifier("");
  ValueNotifier proofImage = ValueNotifier("");
  late ValueNotifier<bool> updatePassword;
  late DeliveryManBloc deliveryBloc;
  List<String> _types = ["admin", "delivery_boy"];
  // String? selectedDropDown = "Passport";
  @override
  void initState() {
    deliveryBloc = DeliveryManBloc.get(context);
    updatePassword = ValueNotifier(widget.id != null);

    if (widget.id != null) {
      deliveryBloc
          .add(GetDeliveryManDetailEvent(context: context, id: widget.id!));
    } else {
      deliveryBloc.clearALlValues();
      deliveryBloc.add(RefreshDeliveryManEvent());
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
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
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      widget.id == null
                          ? AppStrings.newDeliveryMan
                          : AppStrings.editDeliveryMan,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox())
            ],
          )),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: BlocBuilder<DeliveryManBloc, DeliveryManState>(
          builder: (context, state) {
            prettyPrint("CURRENT STATE $state");
            return ElevatedButton(
              onPressed: () {
                if (state is! DeliveryManLoading) {
                  if (deliveryBloc.form.currentState!.validate()) {
                    if (widget.id == null) {
                      deliveryBloc.addDeliveryMan(context);
                    } else {
                      deliveryBloc.updateDeliveryMan(context, widget.id!);
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)))),
              child: state is DeliveryManLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      AppStrings.save,
                      style: TextStyle(fontSize: 18),
                    ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: deliveryBloc.form,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<DeliveryManBloc, DeliveryManState>(
                  builder: (context, state) {
                    return state is DeliveryManDetailLoaded
                        ? buildImageWidget(logo: state.model.image)
                        : buildImageWidget();
                  },
                ),
                spacer20,
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MandatoryText(title: "Staff Type"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: deliveryBloc.selectedDropDownType,
                            builder: (context, data, child) {
                              return DropdownButtonFormField<String>(
                                value: deliveryBloc.selectedDropDownType.value,
                                items: _types
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (String? value) {
                                  deliveryBloc.selectedDropDownType.value =
                                      value ?? "";
                                },
                              );
                            })),
                    Expanded(
                        child: Column(
                      children: [
                        const Text(
                          'Status : ',
                          style: TextStyle(
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w600),
                        ),
                        ValueListenableBuilder(
                            valueListenable: deliveryBloc.enable,
                            builder: (context, data, child) {
                              return CustomSwitch(
                                value: data,
                                onChanged: (val) {
                                  data = val;
                                },
                                enableColor: AppColors.green,
                                disableColor: AppColors.pink,
                              );
                            })
                      ],
                    ))
                  ],
                ),
                spacer20,
                CommonTextField(
                  controller: deliveryBloc.fName,
                  validator: (val) {
                    if (val == "") {
                      return "Please add First Name";
                    } else if (val.length < 2) {
                      return "Please Enter valid Name";
                    }
                  },
                  title: AppStrings.firstName,
                  required: true,
                ),
                spacer5,
                CommonTextField(
                  controller: deliveryBloc.lName,
                  title: AppStrings.secondName,
                  validator: (val) {
                    if (val == "") {
                      return "Please add second Name";
                    }
                  },
                ),
                spacer5,
                CommonTextField(
                  controller: deliveryBloc.email,
                  title: AppStrings.email,
                  required: true,
                  validator: (val) {
                    if (RegExp(AppConstants.emailRegex).hasMatch(val)) {
                    } else {
                      return "Invalid email!. Enter valid email address";
                    }
                  },
                ),
                spacer5,
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: MandatoryText(title: AppStrings.phoneNumber),
                      ),
                    ),
                    spacer10,
                    widget.id == null
                        ? ValueListenableBuilder(
                            valueListenable: deliveryBloc.initialCountryCode,
                            builder: (context, data, child) {
                              prettyPrint("Rebuilding initial countryCode");
                              return IntlPhoneField(
                                controller: deliveryBloc.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                initialCountryCode: "IN",
                                onChanged: (phone) {
                                  // print(phone.completeNumber);
                                  deliveryBloc.completePhone.text =
                                      phone.completeNumber;
                                },
                              );
                            })
                        : ValueListenableBuilder(
                            valueListenable: deliveryBloc.initialCountryCode,
                            builder: (context, data, child) {
                              prettyPrint(
                                  "Rebuilding initial countryCode $data");

                              return data == null
                                  ? const SizedBox()
                                  : IntlPhoneField(
                                      controller: deliveryBloc.phone,
                                      decoration: const InputDecoration(
                                        labelText: 'Phone Number',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      initialCountryCode: 'IN',
                                      onChanged: (phone) {
                                        // print(phone.completeNumber);
                                        deliveryBloc.completePhone.text =
                                            phone.completeNumber;
                                      },
                                    );
                            }),
                  ],
                ),
                // spacer5,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: MandatoryText(title: AppStrings.idType),
                      ),
                    ),
                    spacer10,
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ValueListenableBuilder(
                                valueListenable: deliveryBloc.selectedDropDown,
                                builder: (context, data, child) {
                                  return DropdownButtonFormField<String>(
                                    value: deliveryBloc.selectedDropDown.value,
                                    items: [
                                      "Passport",
                                      "Driving Licence",
                                    ]
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (String? value) {
                                      deliveryBloc.identityType.text =
                                          value ?? "";
                                    },
                                  );
                                })),
                        BlocBuilder<DeliveryManBloc, DeliveryManState>(
                          builder: (context, state) {
                            return state is DeliveryManDetailLoaded
                                ? buildProofImageWidget(
                                    logo: state.model.identityImage)
                                : buildProofImageWidget();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                spacer5,
                CommonTextField(
                  title: AppStrings.idNum,
                  controller: deliveryBloc.identityNumber,
                ),
                spacer5,
                ValueListenableBuilder(
                    valueListenable: updatePassword,
                    builder: (context, data, child) {
                      return CommonTextField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Password must not be empty";
                          } else if (val.length < 6) {
                            return "Password must be have minimum 6 character";
                          }
                        },
                        controller: deliveryBloc.password,
                        title: AppStrings.password,
                        suffix: updatePassword.value
                            ? TextButton(
                                onPressed: () {
                                  deliveryBloc.password.clear();
                                  updatePassword.value = false;
                                },
                                child: const Text(AppStrings.change))
                            : null,
                      );
                    }),
                spacer20
              ],
            ),
          ),
        ),
      ),
    );
  }
}
