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

import '../../../themes/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LoginBloc.get(context);

    return Scaffold(
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
                    title: AppStrings.email,
                    controller: controller.emailController,
                    prefix: SizedBox(
                      width: 15,
                      height: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          AppAssets.email,
                          color: Colors.black,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                    showSuffixIcon: true,
                    validator: (val) {
                      if (val.isEmpty) {
                        return AppConstants.kEmailError;
                      } else if (!RegExp(AppConstants.emailRegex)
                          .hasMatch(val)) {
                        return AppConstants.kEmailError;
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
                    suffix: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is PasswordEyeState) {
                          return IconButton(
                            onPressed: () {
                              controller.add(ShowPasswordEvent(!state.shown));
                            },
                            icon: state.shown
                                ? const Icon(Icons.remove_red_eye_outlined)
                                : const Icon(Icons.password),
                          );
                        }
                        return Container();
                      },
                    ),
                    showSuffixIcon: true,
                    validator: (val) {
                      if (val.isEmpty) {
                        return AppConstants.kPasswordError;
                      } else if (val.length < 6) {
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
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text,
                                    onSuccess: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Success")));
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
                                    }));
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
                  Row(
                    children: const [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          height: 1.5,
                        ),
                      )),
                      Text(AppStrings.or),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          height: 1.5,
                        ),
                      )),
                    ],
                  ),
                  spacer20,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 55,
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.google,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Continue with Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
