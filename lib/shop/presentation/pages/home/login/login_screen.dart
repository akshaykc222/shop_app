import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 30,
                    )
                  ],
                ),
                spacer20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.loginToYourStore,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 20),
                  ),
                ),
                spacer20,
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
                spacer30,
                CommonTextField(
                  title: AppStrings.email,
                  controller: emailController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return AppConstants.kEmailError;
                    } else if (RegExp(AppConstants.emailRegex).hasMatch(val)) {
                      return AppConstants.kEmailError;
                    }
                    return null;
                  },
                ),
                spacer30,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        formKey.currentState?.validate();
                      },
                      child: const Text(
                        AppStrings.continueStr,
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                spacer20,
                Row(
                  children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(),
                    )),
                    Text(AppStrings.or),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(),
                    )),
                  ],
                ),
                spacer20,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
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
    );
  }
}
