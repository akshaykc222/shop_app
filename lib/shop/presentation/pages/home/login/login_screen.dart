import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/manager/bloc/login_bloc/login_bloc.dart';
import 'package:shop_app/shop/presentation/routes/route_manager.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/bottom_navigation_bar.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';

import '../../../manager/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import '../../../themes/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = LoginBloc.get(context);
    ValueNotifier<bool> selectedItem = ValueNotifier(true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.34,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(AppAssets.loginBg))),
                  ),
                  ValueListenableBuilder(
                      valueListenable: selectedItem,
                      builder: (context, data, child) {
                        return Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    selectedItem.value = !selectedItem.value,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: selectedItem.value
                                              ? AppColors.primaryColor
                                              : AppColors.lightGrey)),
                                  child: Center(
                                    child: Text(
                                      AppStrings.storeAdmin,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: selectedItem.value
                                              ? AppColors.primaryColor
                                              : AppColors.lightGrey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    selectedItem.value = !selectedItem.value,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: selectedItem.value
                                              ? AppColors.lightGrey
                                              : AppColors.primaryColor)),
                                  child: Center(
                                    child: Text(
                                      AppStrings.deliveryMan,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: selectedItem.value
                                              ? AppColors.lightGrey
                                              : AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  spacer37,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.loginToYourStore,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  spacer30,
                  spacer5,
                  // Container(
                  //   height: 50,
                  //   decoration: const BoxDecoration(
                  //       border: Border(bottom: BorderSide(color: Colors.black12))),
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         AppAssets.india,
                  //         width: 30,
                  //         height: 30,
                  //         fit: BoxFit.contain,
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       const Text(
                  //         "India (+91)",
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 18,
                  //             letterSpacing: 0.3,
                  //             fontWeight: FontWeight.w400),
                  //       ),
                  //       const Spacer(),
                  //       IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.keyboard_arrow_down_sharp,
                  //             size: 35,
                  //             color: Colors.black38,
                  //           ))
                  //     ],
                  //   ),
                  // ),

                  CommonTextField(
                    title: AppStrings.mobileNumber,
                    controller: controller.phoneController,
                    textInputType: TextInputType.phone,
                    prefix: const SizedBox(
                      width: 15,
                      height: 15,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                    showSuffixIcon: true,
                    validator: (val) {
                      if (val.isEmpty) {
                        return AppConstants.kMobileError;
                      } else if (val.length != 10) {
                        return AppConstants.kMobileError;
                      }
                      return null;
                    },
                  ),
                  spacer10,

                  CommonTextField(
                    title: AppStrings.password,
                    controller: controller.passwordController,
                    prefix: SizedBox(
                      width: 15,
                      height: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          AppAssets.password,
                          color: Colors.black,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                    passwordField: true,
                    // suffix: BlocBuilder<LoginBloc, LoginState>(
                    //   builder: (context, state) {
                    //     if (state is PasswordEyeState) {
                    //       return IconButton(
                    //         onPressed: () {
                    //           controller.add(ShowPasswordEvent(!state.shown));
                    //         },
                    //         icon: controller.showPassWord
                    //             ? const Icon(Icons.remove_red_eye_outlined)
                    //             : const Icon(Icons.password),
                    //       );
                    //     }
                    //     return Container();
                    //   },
                    // ),
                    showSuffixIcon: true,
                    validator: (val) {
                      if (val.isEmpty) {
                        return AppConstants.kPasswordError;
                      } else if (val.length < 4) {
                        return AppConstants.kPasswordInvalidError;
                      }
                      return null;
                    },
                  ),
                  spacer10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: 55,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.add(LoginWithPassword(
                                    email: controller.phoneController.text,
                                    password:
                                        controller.passwordController.text,
                                    onSuccess: () {
                                      controller.phoneController.clear();
                                      controller.passwordController.clear();
                                      var reset =
                                          BottomNavigationCubit.get(context);
                                      reset.changeBottomNav(0);
                                      GoRouter.of(context).go(
                                          AppRouteManager.home(
                                              CustomBottomNavigationItems
                                                  .values[0]));
                                    },
                                    onError: (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "wrong Username or password !")));
                                    },
                                    type: selectedItem.value ? 1 : 2));
                              }
                            },
                            child: state is LoginLoadingState
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : const Text(
                                    AppStrings.login,
                                    style: TextStyle(fontSize: 18),
                                  ));
                      },
                    ),
                  ),
                  spacer20,
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.forgotPass,
                        style: TextStyle(color: AppColors.greyText),
                      ))
                  // Row(
                  //   children: const [
                  //     Expanded(
                  //         child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 15.0),
                  //       child: Divider(
                  //         height: 1.5,
                  //       ),
                  //     )),
                  //     Text(AppStrings.or),
                  //     Expanded(
                  //         child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 15.0),
                  //       child: Divider(
                  //         height: 1.5,
                  //       ),
                  //     )),
                  //   ],
                  // ),
                  // spacer20,
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.8,
                  //   height: 55,
                  //   child: OutlinedButton(
                  //       onPressed: () {},
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset(
                  //             AppAssets.google,
                  //             width: 25,
                  //             height: 25,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           const Text(
                  //             "Continue with Email",
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w400),
                  //           )
                  //         ],
                  //       )),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
