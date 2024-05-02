import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/presentation/manager/bloc/login_bloc/login_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../domain/entities/account_detail_enitity.dart';
import '../../../../themes/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc.get(context);
    loginBloc.add(GetAccountDetailEvent(context));
    super.initState();
  }

  deleteAlert() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (context) => Container(
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      spacer10,
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(
                          AppAssets.deleteGif,
                          width: 80,
                          height: 80,
                        ),
                      ),
                      spacer10,
                      const Text(
                        "Close Your Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        "Please note that account closure is a permanent action, and once your account is closed, it will no longer be available to you and cannot be restored.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      spacer10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.red)),
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(AppStrings.cancel),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {},
                              child: const Text(AppStrings.confirm),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                  // Positioned(
                  //     top: 10,
                  //     right: 10,
                  //     child: InkWell(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: Container(
                  //         width: 30,
                  //         height: 30,
                  //         // padding: const EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey.shade400,
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: const Center(
                  //           child: Icon(
                  //             Icons.close,
                  //             size: 20,
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ))
                ],
              ),
            ));
  }

  Widget sideCard(
      {required String title,
      required String image,
      Color? color,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightBorderColor.withOpacity(0.24)))),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 29,
              height: 29,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? const Color(0XFF484848),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget shimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        spacer37,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.skyBlue),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Image.asset(
                          AppAssets.edit,
                          width: 10,
                          height: 10,
                          color: AppColors.white,
                          fit: BoxFit.cover,
                        ),
                      ))),
            ),
          ],
        ),
        spacer10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 15,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              AppAssets.edit,
              width: 13,
              height: 13,
              color: AppColors.white,
              fit: BoxFit.fill,
            )
          ],
        ),
        spacer5,
        Container(
          width: 130,
          height: 15,
          color: Colors.white,
        ),
        spacer5,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: 220,
            height: 15,
            color: Colors.white,
          ),
        ),
        spacer30,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 30),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.cardLightGrey,
              borderRadius: BorderRadius.circular(19),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0.0, 1.0),
                  blurRadius: 2.0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppAssets.orderProfile,
                    width: 33,
                    height: 40,
                    color: AppColors.skyBlue,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "20",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.skyBlue),
                      ),
                      Text(
                        AppStrings.orders,
                        style: TextStyle(color: AppColors.black),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    AppAssets.revenue,
                    width: 33,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "324 AED",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.skyBlue),
                      ),
                      Text(
                        AppStrings.revenue,
                        style: TextStyle(color: AppColors.black),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        // spacer37,
        sideCard(
            title: AppStrings.changePassword,
            image: AppAssets.changePassword,
            onTap: () {}),
        sideCard(
            title: AppStrings.contactUs,
            image: AppAssets.contactUs,
            onTap: () {}),
        sideCard(
            title: AppStrings.logOut,
            image: AppAssets.logout,
            onTap: () {
              final controller = LoginBloc.get(context);
              controller.logOut(context);
            }),
        sideCard(
            title: AppStrings.deleteAccount,
            image: AppAssets.delete,
            onTap: () {}),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.companyProfile,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              const Expanded(child: SizedBox())
            ],
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state is LoginLoadingState
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: shimmer())
                : state is AccountDetailFetchedState
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          spacer37,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // color: Colors.grey,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(state.data.logo))),
                              ),
                            ],
                          ),
                          spacer10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.data.storeName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.skyBlue),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Wrap(
                                            children: [
                                              EditAccountDetail(
                                                  entity: state.data),
                                            ],
                                          ),
                                        )),
                                child: Image.asset(
                                  AppAssets.edit,
                                  width: 15,
                                  height: 15,
                                  color: AppColors.skyBlue,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                          spacer5,
                          Text(
                            state.data.email,
                            style: const TextStyle(
                                color: AppColors.greyText, fontSize: 15),
                          ),
                          spacer5,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "${state.data.phone}|${state.data.address}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          spacer30,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 34, horizontal: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.orderProfile,
                                      width: 33,
                                      height: 40,
                                      color: AppColors.skyBlue,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.data.orderCount,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: AppColors.skyBlue),
                                        ),
                                        const Text(
                                          AppStrings.orders,
                                          style:
                                              TextStyle(color: AppColors.black),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.revenue,
                                      width: 33,
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // FutureBuilder(
                                        //     // future: getUserData(),
                                        //     builder: (context, snap) {
                                        //   if (snap.hasData) {
                                        //     // var d =
                                        //     //     snap.data as UserDataShort;
                                        //     // bool isLeft = snap.data
                                        //     //         ?.currency.position ==
                                        //     //     "left";
                                        //     return const Text(
                                        //       "",
                                        //       style: TextStyle(
                                        //           fontWeight: FontWeight.w600,
                                        //           fontSize: 15,
                                        //           color: AppColors.skyBlue),
                                        //     );
                                        //   } else {
                                        //     return Text(
                                        //       "${state.data.totalRevenue.toStringAsFixed(2)} ",
                                        //       style: const TextStyle(
                                        //           fontWeight: FontWeight.w600,
                                        //           fontSize: 15,
                                        //           color: AppColors.skyBlue),
                                        //     );
                                        //   }
                                        // }),
                                        const Text(
                                          AppStrings.revenue,
                                          style:
                                              TextStyle(color: AppColors.black),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          // spacer37,
                          sideCard(
                              title: AppStrings.changePassword,
                              image: AppAssets.changePassword,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: const ChangePassword(),
                                        ));
                              }),

                          sideCard(
                              title: AppStrings.contactUs,
                              image: AppAssets.contactUs,
                              onTap: () {}),

                          sideCard(
                              title: AppStrings.privacyPolicy,
                              image: AppAssets.privacy,
                              onTap: () {}),
                          sideCard(
                              title: AppStrings.terms,
                              image: AppAssets.terms,
                              onTap: () {}),
                          sideCard(
                              title: AppStrings.logOut,
                              image: AppAssets.logout,
                              onTap: () {
                                final controller = LoginBloc.get(context);
                                controller.logOut(context);
                              }),
                          sideCard(
                              title: AppStrings.deleteAccount,
                              image: AppAssets.trash,
                              onTap: () {
                                deleteAlert();
                              }),
                          spacer20
                        ],
                      )
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  // final Function onTap;

  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late LoginBloc loginBloc;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    loginBloc = LoginBloc.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      spacer20,
                      const Text(
                        AppStrings.changePassword,
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                    ],
                  ),
                  spacer10,
                  CommonTextField(
                    title: AppStrings.currentPassword,
                    passwordField: true,
                    validator: (val) {
                      if (val.length < 6) {
                        return "Enter a Password length greater than 6 characters.";
                      }
                    },
                    controller: loginBloc.passwordController,
                  ),
                  spacer10,
                  CommonTextField(
                    title: AppStrings.newPassword,
                    validator: (val) {
                      if (val.length < 6) {
                        return "Enter a Password length greater than 6 characters.";
                      }
                    },
                    controller: loginBloc.passwordController,
                  ),
                  spacer10,
                  CommonTextField(
                    title: AppStrings.retypeNewPassword,
                    passwordField: true,
                    validator: (val) {
                      if (val.length < 6) {
                        return "Enter a Password length greater than 6 characters.";
                      }
                    },
                    controller: loginBloc.passwordController,
                  ),
                  spacer10,
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is ChangePasswordState) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Password updated.")));
                          });
                          loginBloc.add(GetAccountDetailEvent(context));
                          Navigator.pop(context);
                        }
                        return state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    loginBloc.add(ChangePasswordEvent(context,
                                        loginBloc.passwordController.text));
                                  }

                                  // Navigator.pop(context);
                                },
                                child: const Text(AppStrings.changePassword));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                // padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class EditAccountDetail extends StatefulWidget {
  final AccountDetailEntity entity;
  const EditAccountDetail({Key? key, required this.entity}) : super(key: key);

  @override
  State<EditAccountDetail> createState() => _EditAccountDetailState();
}

class _EditAccountDetailState extends State<EditAccountDetail> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final imagePickerResult = ValueNotifier("");
  late LoginBloc controller;
  @override
  void initState() {
    controller = LoginBloc.get(context);
    nameController.text = widget.entity.storeName;
    phoneController.text = widget.entity.phone;
    emailController.text = widget.entity.email;
    addressController.text = widget.entity.address;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    AppStrings.updateCompanyProfile,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              spacer10,
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: SizedBox(
                            height: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(AppStrings.uploadProductImage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(
                                          Icons.close,
                                          size: 25,
                                        ))
                                  ],
                                ),
                                spacer20,
                                Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                            onTap: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker();
                                              // Pick an image
                                              // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                              // Capture a photo
                                              final XFile? photo =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (photo != null) {
                                                imagePickerResult.value =
                                                    photo.path ?? "";
                                                controller.image =
                                                    photo.path ?? "";
                                                imagePickerResult
                                                    .notifyListeners();
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 50,
                                                ),
                                                spacer5,
                                                const Text(AppStrings.camara)
                                              ],
                                            ))),
                                    Expanded(
                                        child: GestureDetector(
                                            onTap: () async {
                                              final ImagePicker picker =
                                                  ImagePicker();
                                              // Pick an image
                                              // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                              // Capture a photo
                                              final XFile? photo =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (photo != null) {
                                                imagePickerResult.value =
                                                    photo.path ?? "";
                                                controller.image =
                                                    photo.path ?? "";
                                                imagePickerResult
                                                    .notifyListeners();
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.image_outlined,
                                                  size: 50,
                                                ),
                                                spacer5,
                                                const Text(AppStrings.gallery)
                                              ],
                                            ))),
                                  ],
                                ),
                                spacer20,
                              ],
                            ),
                          ),
                        )),
                child: ValueListenableBuilder(
                    valueListenable: imagePickerResult,
                    builder: (context, data, child) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: imagePickerResult.value != ""
                                ? DecorationImage(
                                    image: FileImage(
                                        File(imagePickerResult.value)))
                                : DecorationImage(
                                    image: NetworkImage(widget.entity.logo))),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.skyBlue),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ))),
                      );
                    }),
              ),
              spacer5,
              CommonTextField(
                title: AppStrings.companyName,
                controller: nameController,
              ),
              spacer5,
              CommonTextField(
                title: AppStrings.email,
                controller: emailController,
              ),
              spacer5,
              CommonTextField(
                title: AppStrings.phoneNumber,
                controller: phoneController,
              ),
              spacer5,
              CommonTextField(
                title: AppStrings.address,
                lines: 5,
                controller: addressController,
              ),
              spacer5,
              SizedBox(
                  width: 300,
                  height: 50,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return state is LoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                controller.add(ChangeAccountDetailsEvent(
                                    ChangeAccountDetailsModel(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        address: addressController.text,
                                        logo: controller.image),
                                    context));
                              },
                              child: const Text(AppStrings.update));
                    },
                  ))
            ],
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                // padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
