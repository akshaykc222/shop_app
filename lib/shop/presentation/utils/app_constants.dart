import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

class AppConstants {
  static const appName = "Shop App ";
  static const emailRegex =
      "^[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*\$";
  static const kEmailError = "Invalid email. please enter a valid email";
  static const kPasswordError = "Enter password";
  static const kPasswordInvalidError =
      "Enter password greater than 6 characters";
}

Widget spacer5 = const SizedBox(
  height: 5,
);
Widget spacer9 = const SizedBox(
  height: 9,
);
Widget spacer10 = const SizedBox(
  height: 10,
);
Widget spacer14 = const SizedBox(
  height: 14,
);
Widget spacer18 = const SizedBox(
  height: 18,
);
Widget spacer17 = const SizedBox(
  height: 17,
);
Widget spacer20 = const SizedBox(
  height: 20,
);
Widget spacer22 = const SizedBox(
  height: 22,
);
Widget spacer37 = const SizedBox(
  height: 37,
);
Widget spacer30 = const SizedBox(
  height: 30,
);

Widget spacer26 = const SizedBox(
  height: 26,
);

Widget spacer24 = const SizedBox(
  height: 24,
);

enum WeekDays { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

handleUnAuthorizedError(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Session Expired!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    "Your Session has expired. Please login again.",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      GoRouter.of(context).goNamed(AppPages.login);
                    },
                    child: const Text("Login"),
                  ),
                )
              ],
            ),
          ));
}
